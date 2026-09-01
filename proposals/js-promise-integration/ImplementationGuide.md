# JSPI Implementation Notes

## Introduction

This note explores some of the techniques used in implementing JSPI in a WebAssembly engine and some of the issues that may be encountered.

Implementing JSPI has some aspects which are quite specific to that API (in particular how Promise objects are handled) and also has many aspects that apply to stack switching and coroutining in general. This is particularly the case for some of the lower-level aspects of implementation.

We will be addressing both low-level and high-level aspects of JSPI implementation.

## Running a promising function

Invoking a `promising` function has a number of distinct phases:

 1. A new `Promise` object is created. This will be the value that is ultimately returned by the promising function.
 1. The wrapped WebAssembly function is called; with arguments coerced from JavaScript into WebAssembly values as dictated by the type of the WebAssembly function.
 1. The result of the call to the wrapped WebAssembly function is used to _fulfill_ the `Promise`: if the WebAssembly function returns normally, then its return value is coerced back into JavaScript and used to resolve the `Promise` object. If the WebAssembly returns with an exception, or traps, then the exception is used to reject the `Promise`.
 1. The `Promise` is returned.

Crucially, the middle steps of the above algorithm are performed on a separate stack -- see [below](#stacks). This allows us to suspend the WebAssembly call but continue the application as a whole.

### Suspending when `Promise`d something

When a suspending import is called from WebAssembly a special wrapper is interposed between the WebAssembly call and the JavaScript function being called. This wrapper coerces arguments from WebAssembly into JavaScript and interprets the result of the JavaScript call:

 1. If the JavaScript function returns a value that is not a `Promise` then that value is coerced back into WebAssembly -- as dictated by the type of the WebAssembly import -- and the wrapper returns the result.
 1. If the JavaScript function returns an exception, then the wrapper propagates the exception and rethrows it to the WebAssembly call.
 1. If the JavaScript function returns a `Promise` object then the wrapper will suspend the computation -- up to the innermost `promising` call -- capture the suspended computation in a continuation object and attach callbacks to that `Promise`:

     1. For a successful resolution to the `Promise` the callback enters the captured continuation with the value returned in the `Promise` -- appropriately coerced into WebAssembly.
     1. For a rejected `Promise` the callback enters the captured continuation by throwing it an exception -- again as given to the callback function.

 After attaching the callbacks, the wrapper causes a return from the promising function's inner body. Depending on whether this was the first time the computation suspended or a subsequent time, this results in the top-level call to the promising function to return (with its `Promise`) or execution will continue within the micro-task scheduler (where no return result is expected).

#### Formalizing with shift/reset

The well known shift/reset framework allows us to write the above algorithm in a pseudo-code fashion:

```[pseudo]
promising(F) => (A)=>{
   P = new Promise();
   reset( ()=>try
     P.resolve(F(A))
   catch e =>
     P.reject(e));
   return P
}

suspending(I) => (X)=> case I(X) in {
   P where isAPromise(A) => shift k in {
       P.then((u)=>k(u),(e)=>k throw e)
   }
   R default => R
 }
```

Of course, the above pseudo code is intended for illustrative purposes only: it is not possible to express the semantics of promising functions in either JavaScript or WebAssembly at this time.

Some observations:

* The body of the `reset` expression is a zero-argument lambda. This reflects our assertion above that stack switching events are always associated with function calls.
* The variables `P` and `A` are free in the `reset` lambda -- they bind the created `Promise` object and the arguments to the call.
* The body of the `reset` lambda handles both successful returns from WebAssembly and exceptional returns. Note that we are not explicitly accounting for WebAssembly traps: they are modeled as exceptions.
* The `suspending` function performs a case analysis on the result of calling the actual imported function -- `I`. If the result looks like a `Promise` then we use `shift` to capture the computation -- up to the innermost `reset` -- and also use the returned continuation in the callback functions attached to the `Promise`.
* The form '`k throw e`' is intended to signify invoking the continuation with the exception `e` -- which is given as a parameter to the `reject` callback function.
* Traditionally, the `shift` operator refers to the innermost occurrence of a `reset` operator in order to delimit the captured continuation. In addition, exceptions are often also modeled in terms of `shift/reset`. However, the combination of the two constructs (promising/suspending and try/catch) is not well formed in this reading of `shift/reset`: the try/catch structure interferes with the promising/suspending structure. It is possible to extend the `shift/reset` formalism to correctly account for this but we choose not to here.
* The use of the `shift/reset` framework here is for illustrative purposes and is not intended to endorse that framework.

## Stacks

The fundamental strategy for implementing JSPI can be summarized using the phrase "run the promising function on a separate stack" - where _promising function_ refers to the result of using the `promising` API call to convert an exported WebAssembly function into one that binds its result into a `Promise` object.

When the time comes to suspend the computation -- because a call to an import resulted in a `Promise` rather than a regular value -- it becomes straightforward to stash the separate stack into a data structure and continue with the original call. Recall that when a `promising` function returns, it returns a `Promise` object. The returned `Promise` object will be fulfilled (resolved or rejected) when the underlying WebAssembly function completes.

If an import resulted in a suspension, the associated `Promise` object will have a _continuation_ attached to it -- via the `then`/`reject` callbacks. This continuation has the stashed stack as a captured variable. When the `Promise` object is fulfilled -- i.e., when the suspending import completes -- the stashed stack can be re-entered and the suspended computation resumed.

This strategy allows us to rapidly _suspend_ the computation when we need to and to equally rapidly _resume_ when the computation can continue. In fact the operations of suspending and resuming are fundamentally constant time operations involving some 20 to 50 machine instructions.

### Stack Switching

The theoretical minimum number of machine instructions to switch between stacks is two: one instruction to save the current SP register in a known location and another to load the SP register. However, in practice, the number of executed instructions is significantly higher for a variety of reasons.

All stack switching events are also associated with a function call. When a computation suspends, it does so (in the case of JSPI) because a function call resulted in a `Promise` being returned. When a function resumes -- due to its associated promise being fulfilled -- it does so in the context of a callback being called by the Browser's micro task queue runner.

In addition, most JSPI-related stack switches also involve some form of _type coercion_ -- between JavaScript values and WebAssembly values. We typically combine this coercion with migrating values between computations. For example, when calling a `promising` function, the coercion of values from JavaScript to WebAssembly is arranged so that coerced values are directly spilled to the new stack -- rather than being first of all coerced and then copied.

Apart from propagating values to a resumed coroutine, there are other factors that must be addressed: checking for stack overflow, managing the allocation of stacks, and responding to stack overflow by allowing stacks to grow in size.

#### Checking for stack overflow

Both JavaScript and WebAssembly call for a check for stack overflow on entry to functions. In addition, many engines require an _interrupt check_ that will cause teh engine to stop if an external interrupt is signaled.

Typically, a stack overflow check involves comparing the value of the SP register with some limit. If we switch between stacks then we must also update the limit pointers -- since each stack will have its own limit. Since the limit pointers are not normally held in registers this increases the theoretical minimum number of instructions for a stack switch from two to four (the new stack limit must be reset -- which takes a minimum of two instructions on Arm).[notonc^]

In V8, the stack overflow and interrupt checks are combined by using a special sentinel value for the stack limit when an interrupt is requested. In particular, a V8 computation is interrupted by setting the stack limit to a special sentinel value -- one that is guaranteed to cause the stack overflow check to fail. Then, if the comparison fails, we must also check that it was a _real_ stack overflow, or if it was an interrupt.

[notonc^]: Note that stack overflow checks are _not_ performed when executing C code. This includes Web API calls made from JavaScript and WebAssembly programs; and it also includes garbage collection triggered by allocation failures.

#### Taking a lock

To avoid a potential race condition between requesting an interrupt and switching between stacks we use an exclusion zone to protect changing the stack limit pointers.

Mutexes and other forms of memory lock have direct and indirect costs associated with them. Depending on the actual architecture of the platform, the memory synchronization across multiple cores implied by a lock can cause significant performance issues for stack switching. However, combining the checks does allow the infrequent case (interrupt) to be merged in with the frequent case (stack overflow).

### Stack Allocation Strategies

Using JSPI to realize responsive applications is fundamentally less resource intensive than using worker threads. This enables application patterns that are not feasible when using workers. For example, the simultaneous downloading of thousands of images -- using suspended coroutines to represent the processing tasks for each image.

Recall that our strategy for JSPI involves allocating a stack for each call to a `promising` function. This raises the question of managing the stack memories when there may be a large number of suspendable computations.

The stack memory must be separately allocated from the garbage collected heap because GC can (and does) relocate objects during garbage collection. Since a stack typically has location sensitive pointers embedded in it (for example inter-frame pointers) stack memory cannot easily be moved.

A related question is how large to make the stack memories; especially given the constraints alluded to above. A primary difficulty in deciding the size of a stack memory is that we cannot know ahead of time how much stack space a given promising function needs. Using a large fixed size (say 1MB) is not practical on most devices; and in any case is very wasteful in memory. Using a small fixed size risks unnecessary stack overflow in promising (sic) functions.

One solution takes the form of _growable stacks_: when a stack is first allocated for a promising function only a small stack memory is used -- for example: 32K bytes. This is likely to be sufficient for many, if not most, coroutines. However, if a given coroutine overflows this allocation then we _grow_ its stack.

#### Growing by switching

For the same reasons that we do not allocate stack memory in the garbage collected heap we also do not simply grow a stack by reallocating it. Instead, when a stack overflow is detected on a function call, we allocate a new stack and switch to it for the function call. This is the so-called _segmented stack_ approach to implementing growable stacks.

We use a heuristic strategy to determine the size of the newly allocated stack segment. In particular, a primary concern is to avoid a performance cliff problem when segmenting stacks. This can arise when the function that causes the stack overflow/split to occur has many calls to functions itself.

For example, if a function calls another function in the body of a loop and each such call causes the stack overflow/split to occur then that function's performance could suffer significantly.

We resolve this with a combination of exponential backoff in the allocation size and local caching of stack segments. The former reduces the probability of subsequent overflow/splits occurring and the latter reduces the cost of the overflow itself.

#### Caching stack memories

Related to the issue of stack overflow for promising functions is the one of frequent but shallow calls to promising functions. Particularly since we don't use the GC allocated heap for stack memories, allocating and freeing stack memories can also be resource intensive.

One straightforward approach to this is also to cache stack memories. A stack memory becomes available for reuse when the promising function finally returns. Instead of freeing the stack memory (or waiting for GC to trigger the release of the memory) we can aoivd some of the costs of allocation and freeing by maintaining a cache of stack memories.

For applications that make frequent uses of JSPI promising but are not otherwise reentrant the effect will be that a cache of a single stack memory will likely be sufficient. We have observed significant performance benefits of such stack caching.

## Integrating with embedder hosts

One of the most immediate challenges with our strategy of using different stacks is that most embedder environments are not adapted to working with multiple stacks. This is particularly true for languages like C/C++.

As a result, there are a number of design problems that need to be resolved when implementing JSPI:

* How to actually have multiple stacks, and to switch between them.
* How to account for utilities and libraries that depend on being able to 'walk the stack'.
* How to safely invoke embedder code when the actual stack size may be much smaller than originally anticipated.

### Control Flow Integrity

Control Flow Integrity (CFI) refers to security techniques that are used to prevent so-called ‘return oriented programming’. Typically requiring some hardware support – to prevent bad actors from circumventing the effort – CFI aims to prevent the use of functions’ entry points and exit points except as intended by the developer.

There are two common approaches used for CFI: signing function return addresses and maintaining a shadow stack in a private memory. In addition, so-called label target instructions are also used: to prevent jumping to an instruction address (or even within instructions) that was not anticipated.

Clearly, stack switching of any form has the intended effect of not always returning as expected from a function call. This can be a particular problem with hardware maintained shadow stacks. When we switch stacks we must also inform the operating system and hardware that we have done so.

On Intel hardware, creating a new shadow stack is a privileged operation: requiring a system call. However, switching between shadow stacks is not. The WebAssembly compiler, however, must emit the required instructions to switch the shadow stacks when switching between WebAssembly stacks – unfortunately further increasing the cost of a stack switch.

Other techniques used for CFI protection are less onerous: return address signing[^signing] is not affected by a stack switch and jumps generated by the WebAssembly compiler can be associated with label target instructions.

[^signing]: Return address signing is achieved by entangling the actual return address with the value of the SP register at the time of the call. This relies on the fact that most modern hardware implementations are fully fully 64 bit: physical addresses are limited to 48 bits. The remaining 16 bits in a 64 bit word can be used to encrypt the SP register with the return address.

### Integrating with JavaScript

One of the more tempting design choices revolves around whether or not to switch _from_ a secondary stack to the original main stack when calling a normal (i.e., not wrapped) import call to JavaScript.

Switching back when calling JavaScript means that applications that do not use JSPI are not adversely affected by the JSPI implementation. It also simplifies the handling of so-called embedder code which is typically written in languages that do not honor stack limits.

### Executing host code

As noted above, most programming languages are not designed to be executed in a coroutining context. In addition, there are many algorithms that rely on being able to ‘walk the stack’.

For example, many profilers operate by interrupting the targeted application on a periodic basis, inspecting the execution stack to see what functions are being called, and recording the result. Such profilers have to be rewritten or extended if they are to take into account the fact that an application may actually be using multiple stacks.

Since a WebAssembly engine is designed to be embedded, executing on multiple stacks may violate assumptions that the embedder makes when invoking WebAssembly code.

This issue surfaces not only for explicit imports to host APIs but also for the many cases where the WebAssembly engine must invoke embedder function to support the semantics of WebAssembly itself. For example, when allocating a `struct`, there are two paths that the engine may take: one where the memory is known to be available and one which may result in the garbage collector being invoked. By switching to the central stack for such slow paths minimises the risk of running hist code while hopefully preserving the performance benefits of not switching.

## Expected Performance

The fundamental performance promise of JSPI is that, once the cost of allocation of a stack is accounted for, the cost of switching – whether it is for suspending and resuming a WebAssembly code or whether it is to execute JavaScript and/or host code – is constant.

The actual cost of a stack switch is of the order of five to 10 C function calls. Some of that may be avoidable in the future, but there are good reasons to believe that the minimum cost is 3 function calls.

Note that this is significantly better than the expected costs in alternative strategies – such as stack copying or CPS transform. In those cases, stack switching is no longer constant but dependent on the depth of the computation being switched.