# WebAssembly Content Security Policy

This note describes a recommendation to the WebAppSec WG to extend Content Security Policy (CSP) to support compiling and executing WebAssembly modules.

## Background: WebAssembly, Trust and Safety

In order for a user to experience the benefits of using a particular WebAssembly module there are three (at least) parties that must collaborate: the browser (or other host environment), the publisher (the author of the WebAssembly module) and the user. Each party seeks some form of guarantee from the other parties that allow that party to trust the others. This trust centric modeling allows us to paint a more accurate picture of WebAssembly security.

### WebAssembly Sandbox

WebAssembly has a sandbox-style security model which focuses on limiting the potential damage a WebAssembly module can do to its host environment. For example, a WebAssembly module is not permitted to access any functions from the host other than those explicitly passed to it via imports. Similarly, a WebAssembly module cannot directly access the evaluation stack; which also limits the potential for attacks based on manipulating return addresses and other important stack data.

By imposing this sandbox on the execution of a WebAssembly model, the browser (or other host) gains sufficient trust that browser is willing to permit the WebAssembly code to execute.

This does not, however, provide any guarantees that WebAssembly modules compute correct results: it is still possible that an incorrectly programmed module may corrupt data, produce invalid results and be subject to attacks such as SQL injection and even buffer overrun affecting data structures within an application. Since the memory used by a WebAssembly module may be shared via ArrayBuffers these faults may be visible to and affect other WebAssembly and JavaScript modules that also share the same memory. Other memory faults - such as use-after-free and accessing uninitialized memory - are also similarly not protected against by the engine. 

We should also note that a malicious module may be completely safe in terms of the resources from the host that it uses and still cause significant harm to the user. A classic example of this would be a surruptiously loaded crypto-mining WebAssembly module.

In addition, the sandbox model does not manage _which_ WebAssembly modules are executed. Controlling which WebAssembly modules are executed is the primary focus of CSP.

### CSP Resource Control

CSP, broadly, allows a publisher to control what resources can be loaded as part
of a site. These resources can include images, audio, video, or scripts. In particular, a suitable CSP should allow the publisher to declare to the host which WebAssembly modules may be executed by the browser on behalf of the user.

It is important to manage this as malicious WebAssembly modules could exfiltrate data from the site. Images could display misleading or
incorrect information. Fetching resources leaks information about the user to
untrusted third parties.

Viewed in terms of _trust_ modeling, CSP allows the content publisher to establish a trust contract with the browser -- and therefore be willing to let the browser execute the publisher's code. It does not, however, address the trust that a user must express when accessing functionality from a WebAssembly module. This is crucially important; however, it is also beyond the scope of this note.

### WebAssembly Execution API

Executing WebAssembly has several steps. 

1. First there are the raw WebAssembly
bytes, which typically are loaded using the [fetch
API](https://fetch.spec.whatwg.org/). 

1. Next, the bytes are compiled using
`WebAssembly.compile` or `WebAssembly.compileStreaming` into a
`WebAssembly.Module`. This module is not yet executable, but WebAssembly
implementations may choose to translate the WebAssembly code into machine code
at this step. 

1. Finally, a WebAssembly module
is combined with an _import object_ using `WebAssembly.instantiate` to create an
`WebAssembly.Instance` object. The import object, broadly, defines the
capabilities of the resulting instance, optionally including a
`WebAssembly.Memory`, bindings for the WebAssembly function imports, and an
indirect function call table.  

    Note that, via the `start` function, some functionality within a WebAssembly module may start executing at this point. However, for the most part, the host accesses WebAssembly functions through the instance's exports.

These steps provide the core of the WebAssembly API, but there are several other
methods provided as well. These are summarized below along with their risks that
are related to CSP.

### Risk Analysis of WebAssembly API

[**`WebAssembly.validate`**](https://webassembly.github.io/spec/js-api/index.html#dom-webassembly-validate)
checks whether the given bytes comprise a valid WebAssembly program. In other
words, it checks whether the bytes are syntactically correct and valid according
to the WebAssembly type system.

_Risks:_ Limited to certain denial of service style attacks. Currently the cost of validating a WebAssembly module is linear on the size of the module; however, certain anticipated changes to the WebAssembly type system may change that.

[**`new WebAssembly.Module`**](https://webassembly.github.io/spec/js-api/index.html#dom-module-module)
synchronously creates a `WebAssembly.Module` from WebAssembly bytes. This is a
synchronous version of `WebAssembly.compile`.

_Risks:_ many implementations will generate machine code at this step, even
though it is not yet exposed as executable code to the surrounding program. 

[**`WebAssembly.compile`**](https://webassembly.github.io/spec/js-api/index.html#dom-webassembly-compile)
provides a `Promise` that resolves to a `WebAssembly.Module` generated from the
provided WebAssembly bytes. This is an asynchronous version of `new
WebAssembly.Module`.

_Risks:_ equivalent to `new WebAssembly.Module`.

[**`WebAssembly.compileStreaming`**](https://webassembly.github.io/spec/web-api/index.html#dom-webassembly-compilestreaming)
creates a `WebAssembly.Module` from the WebAssembly bytes contained in the
provided `Response` object.

_Risks:_ equivalent to `new WebAssembly.Module`.

[**`WebAssembly.instantiate`**](https://webassembly.github.io/spec/js-api/index.html#dom-webassembly-instantiate)
accepts either WebAssembly bytes or a `WebAssembly.Module` and an import object.
The function returns a `WebAssembly.Instance` that allows executing the
WebAssembly code. If WebAssembly bytes are provided, `instantiate` will first
perform the steps of `WebAssembly.compile`.

_Risks:_ loads executable code into the running program and execute any included `start` function.

As noted above, WebAssembly functions are only able to access objects reachable from the import object. The instance
does not have unrestricted access to the JavaScript global object.

[**`WebAssembly.instantiateStreaming`**](https://webassembly.github.io/spec/web-api/index.html#dom-webassembly-instantiatestreaming)
accepts a `Response` containing WebAssembly bytes and an import object, performs
the operations behind `WebAssembly.compileStreaming` on these bytes and then
creates a `WebAssembly.Instance`.

_Risks:_ equivalent to `WebAssembly.instantiate`.

### Out of Scope Threats

* **Bugs in the browser**. We assume correct implementations of image decoders,
  script compilers, etc. CSP does not protect against malicious inputs that can,
  for example, trigger buffer overflows.
* **Resource exhaustion**. Computation performed by scripts uses memory and CPU
  time and can therefore cause a denial of service on the browser. Protecting
  against this is one reason site owners use CSP, but denial of service is not a
  first order consideration for CSP. Scripts are dangerous not because of their
  resource consumption but because of other effects that can cause.

## WebAssembly and CSP

As noted earlier, CSP allows publishers to control what resources are loaded into a browser from a Web application. This includes resources that are dynamically created as well as those loaded directly. There is no direct equivalent of a `script` element for WebAssembly modules; although it is possible that such an feature may be specified in the future. Instead, WebAssembly modules are compiled and instantiated via a JavaScript API. Thus our focus on CSP for WebAssembly is on that API.

### The `HostEnsureCanCompileWasmBytes` Policy Point

It is proposed that the above APIs are _gated_ by a policy point: `HostEnsureCanCompileWasmBytes`. (This is sometimes referred to as an _abstract operation_ that must be performed by the host to permit the compilation.) 

#### `HostEnsureCanCompileWasmBytes`

If `HostEnsureCanCompileWasmBytes` is not enabled, then the `WebAssembly.compile` and `WebAssembly.compileStreaming` functions fail with a `WebAssembly.CompileError` exception. Otherwise, these API functions return results depending on the internal integrity of the WebAssembly module being compiled.

### The `wasm-unsafe-eval` source directive

We recommend that a new CSP policy directive `wasm-unsafe-eval` be created. If set in the headers of a page, then the  `HostEnsureCanCompileWasmBytes` policy point is enabled; which, in turn, allows the page to load, compile and instantiate WebAssembly code. This would apply to both the inline APIs (`WebAssembly.compile` etc.) and the streaming APIs (`WebAssembly.compileStreaming` et el.) The details of these abstract operations will be incorporated into a future version of the CSP specification.

Given the current usage of the CSP policy `unsafe-eval` to gate both JavaScript `eval` and instantiating WebAssembly modules, we propose that that behavior be allowed to continue; but that `wasm-unsafe-eval` should have no implication for JavaScript loading or evaluation or use of `eval` in JavaScript. NOTE: Providing a directive to allow JavaScript `eval` without WebAssembly doesn't seem immediately useful, and so has been left out intentionally.

#### Proposed Policy Behavior

With the `wasm-unsafe-eval` source, there are two options for managing WebAssembly execution: `unsafe-eval` and `wasm-unsafe-eval`. The former is primarily intended to govern JavaScript execution -- specifically those JS features that can be used to construct programs from text. However, it has been extended to allow WebAssembly execution. The second is a more targeted source keyword that only applies to WebAssembly.

* If the `unsafe-eval` source keyword is used, then this overrides any occurence of `wasm-unsafe-eval` in the CSP policy. 

* If the `wasm-unsafe-eval` source keyword is used, and the `unsafe-eval` keyword is not present, then WebAssembly modules may be compiled and instantiated.

  One advantage of this is that a website can permit WebAssembly modules to be used without also enabling JavaScript's `eval` keyword.

On the event of failure, then a `CompileError` should be thrown by the `WebAssembly.compile` and related API calls.

### Using existing CSP script-src policies

Currently, WebAssembly modules are anomolous within the Web platform because there is no specific HTML element that references WebAssembly modules. It is reasonable to suggest that the existing `script` element may one day be extended to also include WebAssembly modules. In that event, it is also reasonable to consider the use of the CSP `script-src` source keyword to include WebAssembly as well as JavaScript.

However, it may not be wise to extend the scope of CSP's `script-src` source in this way. The reasons for this are that it could break existing websites and that the specific rules for `script-src` are too tailored to the requirements of JavaScript.

* Extending `script-src` to include WebAssembly has the potential to compromise a website that currently uses a CSP policy for JavaScript that was not intended to support WebAssembly.

* Using a _white list_ approach for allowable domains to source executable can be shown to be difficult to manage in practice. This is especially true for JavaScript, but is also true for WebAssembly. 

  * The primary issue with white listing a domain is that it allows _all_ code from that domain. However, many domains -- such as CDNs -- host many code modules; many more than owners of websites can reasonably be aware of.
