# Proposal motivation

This document has the purpose of explaining better the underlying issues that the proposal
aim to solve, and why they can't be solved in other ways (for example with better tooling).

# Example code

We will refer to the following example code, which is purposefully simple to make
the analysis easier. The analysis generalizes for more complex code.

```
void foo();
int run(int i) {
    int ret = 0;
    int b = 0;
    while(i) {
        if(__builtin_expect(b==i-1, 0)) {
            foo();
        }
        b++;
        ret += b;
        if(b>=i)
            break;
    }
    return ret;
}
```

`__builtin_expect` is a gcc and clang specific builtin that hints the compiler that
we know that `b==i-1` is very likely to be false.

The compiler can use this information to make better decisions regarding register allocation,
inlining, code layout, etc...

For example here the compiler may decide that it is not worth it to inline the call to `foo()`,
and that in the resulting machine code the call should be placed far from the rest of the code.

# Native x86-64 code generation

We can see the effect of `__builtin_expect` when compiling native code by compiling
first with the expected value `1` and then `0`:

```
// expected 1
0000000000000000 <run>:
   0:	          55                   	push   rbp
   1:	          41 57                	push   r15
   3:	          41 56                	push   r14
   5:	          53                   	push   rbx
   6:	          50                   	push   rax
   7:	          41 89 ff             	mov    r15d,edi
   a:	          85 ff                	test   edi,edi
   c:	          bb 01 00 00 00       	mov    ebx,0x1
  11:	          41 be 01 00 00 00    	mov    r14d,0x1
  17:	          44 0f 4f f7          	cmovg  r14d,edi
  1b:	          41 f7 de             	neg    r14d
  1e:	          31 ed                	xor    ebp,ebp
  20:	   /----> 45 85 ff             	test   r15d,r15d
  23:	/--|----- 74 21                	je     46 <run+0x46>
  25:	|  |      41 39 df             	cmp    r15d,ebx
  28:	|  |  /-- 75 05                	jne    2f <run+0x2f>
  2a:	|  |  |   e8 00 00 00 00       	call   2f foo
  2f:	|  |  \-> 01 dd                	add    ebp,ebx
  31:	|  |      41 8d 04 1e          	lea    eax,[r14+rbx*1]
  35:	|  |      83 c0 01             	add    eax,0x1
  38:	|  |      89 d9                	mov    ecx,ebx
  3a:	|  |      83 c1 01             	add    ecx,0x1
  3d:	|  |      89 cb                	mov    ebx,ecx
  3f:	|  |      83 f8 01             	cmp    eax,0x1
  42:	|  \----- 75 dc                	jne    20 <run+0x20>
  44:	|     /-- eb 02                	jmp    48 <run+0x48>
  46:	\-----|-> 31 ed                	xor    ebp,ebp
  48:	      \-> 89 e8                	mov    eax,ebp
  4a:	          48 83 c4 08          	add    rsp,0x8
  4e:	          5b                   	pop    rbx
  4f:	          41 5e                	pop    r14
  51:	          41 5f                	pop    r15
  53:	          5d                   	pop    rbp
  54:	          c3                   	ret
```

```
// expected 0
0000000000000000 <run>:
   0:	                55                   	push   rbp
   1:	                41 57                	push   r15
   3:	                41 56                	push   r14
   5:	                53                   	push   rbx
   6:	                50                   	push   rax
   7:	                41 89 ff             	mov    r15d,edi
   a:	                85 ff                	test   edi,edi
   c:	                bb 01 00 00 00       	mov    ebx,0x1
  11:	                41 be 01 00 00 00    	mov    r14d,0x1
  17:	                44 0f 4f f7          	cmovg  r14d,edi
  1b:	                41 f7 de             	neg    r14d
  1e:	                31 ed                	xor    ebp,ebp
  20:	            /-> 45 85 ff             	test   r15d,r15d
  23:	/-----------|-- 74 23                	je     48 <run+0x48>
  25:	|           |   41 39 df             	cmp    r15d,ebx
  28:	|     /-----|-- 74 17                	je     41 <run+0x41>
  2a:	|  /--|-----|-> 01 dd                	add    ebp,ebx
  2c:	|  |  |     |   41 8d 04 1e          	lea    eax,[r14+rbx*1]
  30:	|  |  |     |   83 c0 01             	add    eax,0x1
  33:	|  |  |     |   89 d9                	mov    ecx,ebx
  35:	|  |  |     |   83 c1 01             	add    ecx,0x1
  38:	|  |  |     |   89 cb                	mov    ebx,ecx
  3a:	|  |  |     |   83 f8 01             	cmp    eax,0x1
  3d:	|  |  |     \-- 75 e1                	jne    20 <run+0x20>
  3f:	|  |  |  /----- eb 09                	jmp    4a <run+0x4a>
  41:	|  |  \--|----> e8 00 00 00 00       	call   46 foo
  46:	|  \-----|----- eb e2                	jmp    2a <run+0x2a>
  48:	\--------|----> 31 ed                	xor    ebp,ebp
  4a:	         \----> 89 e8                	mov    eax,ebp
  4c:	                48 83 c4 08          	add    rsp,0x8
  50:	                5b                   	pop    rbx
  51:	                41 5e                	pop    r14
  53:	                41 5f                	pop    r15
  55:	                5d                   	pop    rbp
  56:	                c3                   	ret
```

You can see that if the compiler expects the branch to be taken, it puts the call
with the rest of the loop code, while if it expects it to be not take, it puts it after.

This is to maximise the likelyhood that the most often executed code is in the instruction cache.

# Wasm code generation

When compiling into Wasm, the compiler can still use `__builtin_expect` to make better decisions:

For example it can still decide that inlining the call to `foo()` is not worth it.

But a key difference is that in the case of Wasm, the Wasm code is not the actual machine
code that the cpu will execute.
Moreover, Wasm's structured control flow has no 1 to 1 relationship with the final machine code
that a Wasm engine will generate in tems of code layout.

This means that there is no way that a Wasm compiler can tell a Wasm engine how it would
like the machine code to be laid out.

The Wasm generated from the above code is the following (regardless of the presence of `__builtin_expect`):

```
func[2] <run>:
  local[0..3] type=i32
  local.get 0
  i32.const 4294967295
  i32.add
  local.set 1
  local.get 0
  i32.const 0
  i32.ne
  local.set 2
  i32.const 0
  local.tee 3
  local.tee 4
  loop
    local.get 2
    if
      local.get 4
      local.get 1
      i32.eq
      if
        call 0 <i.foo>
      end
      local.get 4
      i32.const 1
      i32.add
      local.tee 4
      local.get 3
      i32.add
      local.set 3
      local.get 4
      local.get 0
      i32.lt_s
      br_if 1
      local.get 3
      return
    end
  end
  end
```

And the machine code generated by V8's TurboFan is:

```
0x3ed39fc0d640     0  55             push rbp
0x3ed39fc0d641     1  4889e5         REX.W movq rbp,rsp
0x3ed39fc0d644     4  6a0a           push 0xa
0x3ed39fc0d646     6  56             push rsi
0x3ed39fc0d647     7  4883ec20       REX.W subq rsp,0x20
0x3ed39fc0d64b     b  488b5e23       REX.W movq rbx,[rsi+0x23]
0x3ed39fc0d64f     f  488945e8       REX.W movq [rbp-0x18],rax
0x3ed39fc0d653    13  483b23         REX.W cmpq rsp,[rbx]
0x3ed39fc0d656    16  0f869b000000   jna 0x3ed39fc0d6f7  <+0xb7>
0x3ed39fc0d65c    1c  83f800         cmpl rax,0x0
0x3ed39fc0d65f    1f  0f95c3         setnzl bl
0x3ed39fc0d662    22  0fb6db         movzxbl rbx,rbx
0x3ed39fc0d665    25  33c9           xorl rcx,rcx
0x3ed39fc0d667    27  48895dd0       REX.W movq [rbp-0x30],rbx
0x3ed39fc0d66b    2b  488bd1         REX.W movq rdx,rcx
0x3ed39fc0d66e    2e  488bf9         REX.W movq rdi,rcx
0x3ed39fc0d671    31  660f1f840000000000 nop
0x3ed39fc0d67a    3a  660f1f440000   nop
0x3ed39fc0d680    40  4c8b4623       REX.W movq r8,[rsi+0x23]
0x3ed39fc0d684    44  493b20         REX.W cmpq rsp,[r8]
0x3ed39fc0d687    47  0f867c000000   jna 0x3ed39fc0d709  <+0xc9>
0x3ed39fc0d68d    4d  837dd000       cmpl [rbp-0x30],0x0
0x3ed39fc0d691    51  0f8454000000   jz 0x3ed39fc0d6eb  <+0xab>
0x3ed39fc0d697    57  448d40ff       leal r8,[rax-0x1]
0x3ed39fc0d69b    5b  443bc7         cmpl r8,rdi
0x3ed39fc0d69e    5e  0f8539000000   jnz 0x3ed39fc0d6dd  <+0x9d>
0x3ed39fc0d6a4    64  448b462b       movl r8,[rsi+0x2b]
0x3ed39fc0d6a8    68  4d03c5         REX.W addq r8,r13
0x3ed39fc0d6ab    6b  458b4007       movl r8,[r8+0x7]
0x3ed39fc0d6af    6f  4d03c5         REX.W addq r8,r13
0x3ed39fc0d6b2    72  4c8b4e2f       REX.W movq r9,[rsi+0x2f]
0x3ed39fc0d6b6    76  4d8b09         REX.W movq r9,[r9]
0x3ed39fc0d6b9    79  48894de0       REX.W movq [rbp-0x20],rcx
0x3ed39fc0d6bd    7d  48897dd8       REX.W movq [rbp-0x28],rdi
0x3ed39fc0d6c1    81  4c8bd6         REX.W movq r10,rsi
0x3ed39fc0d6c4    84  498bf0         REX.W movq rsi,r8
0x3ed39fc0d6c7    87  4d8bc2         REX.W movq r8,r10
0x3ed39fc0d6ca    8a  41ffd1         call r9
0x3ed39fc0d6cd    8d  488b45e8       REX.W movq rax,[rbp-0x18]
0x3ed39fc0d6d1    91  488b4de0       REX.W movq rcx,[rbp-0x20]
0x3ed39fc0d6d5    95  488b7dd8       REX.W movq rdi,[rbp-0x28]
0x3ed39fc0d6d9    99  488b75f0       REX.W movq rsi,[rbp-0x10]
0x3ed39fc0d6dd    9d  83c701         addl rdi,0x1
0x3ed39fc0d6e0    a0  03cf           addl rcx,rdi
0x3ed39fc0d6e2    a2  3bf8           cmpl rdi,rax
0x3ed39fc0d6e4    a4  7c9a           jl 0x3ed39fc0d680  <+0x40>
0x3ed39fc0d6e6    a6  e907000000     jmp 0x3ed39fc0d6f2  <+0xb2>
0x3ed39fc0d6eb    ab  33c0           xorl rax,rax
0x3ed39fc0d6ed    ad  488be5         REX.W movq rsp,rbp
0x3ed39fc0d6f0    b0  5d             pop rbp
0x3ed39fc0d6f1    b1  c3             retl
0x3ed39fc0d6f2    b2  488bc1         REX.W movq rax,rcx
0x3ed39fc0d6f5    b5  ebf6           jmp 0x3ed39fc0d6ed  <+0xad>
0x3ed39fc0d6f7    b7  e884fbffff     call 0x3ed39fc0d280     ;; wasm stub: WasmStackGuard
0x3ed39fc0d6fc    bc  488b45e8       REX.W movq rax,[rbp-0x18]
0x3ed39fc0d700    c0  488b75f0       REX.W movq rsi,[rbp-0x10]
0x3ed39fc0d704    c4  e953ffffff     jmp 0x3ed39fc0d65c  <+0x1c>
0x3ed39fc0d709    c9  48894de0       REX.W movq [rbp-0x20],rcx
0x3ed39fc0d70d    cd  48897dd8       REX.W movq [rbp-0x28],rdi
0x3ed39fc0d711    d1  e86afbffff     call 0x3ed39fc0d280     ;; wasm stub: WasmStackGuard
0x3ed39fc0d716    d6  488b45e8       REX.W movq rax,[rbp-0x18]
0x3ed39fc0d71a    da  488b4de0       REX.W movq rcx,[rbp-0x20]
0x3ed39fc0d71e    de  488b7dd8       REX.W movq rdi,[rbp-0x28]
0x3ed39fc0d722    e2  488b75f0       REX.W movq rsi,[rbp-0x10]
0x3ed39fc0d726    e6  e962ffffff     jmp 0x3ed39fc0d68d  <+0x4d>
0x3ed39fc0d72b    eb  90             nop
```

As you can see the call to `foo()` (`call r9`) is in the middle of the loop code.

Is there a way to produce different Wasm code which will result in the call being after
the rest of the loop code?

No, because:

- the call is part of the loop
- Wasm loops can only have one entry point

Therefore it is impossible in Wasm to have some code part of a loop moved after it,
because it would cause irreducible control flow.

Of course we could introduce irreducible control flow and then turn it into reducible control flow
again (Wasm compilers already must be able to do this), but there are only two way of
fixing the irreducible control flow: duplicating the code or introducing a new variable
to direct the control flow:

- The first alternative is not feasible in the general case because the code duplication
can incur in exponential blowup

- The second is feasible but introduces so much overhead that it defeats the purpose

# Branch Hinting proposal

The underlying problem is that there is a gap of information between the high level source code
and the final machine code that the engine runs.

The Branch Hinting proposal aims to close the gap by explicitly passing on the missing information
to the engine.

As a matter of fact, V8 already has the concept of "branch hinting": It is used internally
to produce better code in the presence of unlikely conditions.

It is also currently used to implement the experimental `br_on_null` instruction (with the assumption
that it is unlikely to be null).

These of course are implementation details, but they hint at the fact that this functionality
is valuable.

Without this proposal, performance sesitive applications that benefits from branch hinting
may have to rely on internal engine behavior to achieve maximum performance.

For example the CheerpX virtual machine is currently experimenting with using br_on_null to take advantage of internal branch hinting in V8.
Even though this solution is inefficient the performance gains are nonetheless significant.
Proper support for branch hinting would improve the performance even more.

# Wasm code generation with branch hinting

The V8 POC with branch hinting support produces the following machine code for our example code:

```
0xfe77b01d640     0  55             push rbp
0xfe77b01d641     1  4889e5         REX.W movq rbp,rsp
0xfe77b01d644     4  6a0a           push 0xa
0xfe77b01d646     6  56             push rsi
0xfe77b01d647     7  4883ec20       REX.W subq rsp,0x20
0xfe77b01d64b     b  488b5e23       REX.W movq rbx,[rsi+0x23]
0xfe77b01d64f     f  483b23         REX.W cmpq rsp,[rbx]
0xfe77b01d652    12  0f8656000000   jna 0xfe77b01d6ae  <+0x6e>
0xfe77b01d658    18  83f800         cmpl rax,0x0
0xfe77b01d65b    1b  0f95c3         setnzl bl
0xfe77b01d65e    1e  0fb6db         movzxbl rbx,rbx
0xfe77b01d661    21  33c9           xorl rcx,rcx
0xfe77b01d663    23  488bd1         REX.W movq rdx,rcx
0xfe77b01d666    26  488bf9         REX.W movq rdi,rcx
0xfe77b01d669    29  0f1f8000000000 nop
0xfe77b01d670    30  4c8b4623       REX.W movq r8,[rsi+0x23]
0xfe77b01d674    34  493b20         REX.W cmpq rsp,[r8]
0xfe77b01d677    37  0f8644000000   jna 0xfe77b01d6c1  <+0x81>
0xfe77b01d67d    3d  83fb00         cmpl rbx,0x0
0xfe77b01d680    40  0f841b000000   jz 0xfe77b01d6a1  <+0x61>
0xfe77b01d686    46  448d40ff       leal r8,[rax-0x1]
0xfe77b01d68a    4a  443bc7         cmpl r8,rdi
0xfe77b01d68d    4d  0f845b000000   jz 0xfe77b01d6ee  <+0xae>
0xfe77b01d693    53  83c701         addl rdi,0x1
0xfe77b01d696    56  03cf           addl rcx,rdi
0xfe77b01d698    58  3bf8           cmpl rdi,rax
0xfe77b01d69a    5a  7cd4           jl 0xfe77b01d670  <+0x30>
0xfe77b01d69c    5c  e908000000     jmp 0xfe77b01d6a9  <+0x69>
0xfe77b01d6a1    61  488bc2         REX.W movq rax,rdx
0xfe77b01d6a4    64  488be5         REX.W movq rsp,rbp
0xfe77b01d6a7    67  5d             pop rbp
0xfe77b01d6a8    68  c3             retl
0xfe77b01d6a9    69  488bc1         REX.W movq rax,rcx
0xfe77b01d6ac    6c  ebf6           jmp 0xfe77b01d6a4  <+0x64>
0xfe77b01d6ae    6e  488945e8       REX.W movq [rbp-0x18],rax
0xfe77b01d6b2    72  e8c9fbffff     call 0xfe77b01d280       ;; wasm stub: WasmStackGuard
0xfe77b01d6b7    77  488b45e8       REX.W movq rax,[rbp-0x18]
0xfe77b01d6bb    7b  488b75f0       REX.W movq rsi,[rbp-0x10]
0xfe77b01d6bf    7f  eb97           jmp 0xfe77b01d658  <+0x18>
0xfe77b01d6c1    81  488945e8       REX.W movq [rbp-0x18],rax
0xfe77b01d6c5    85  48894de0       REX.W movq [rbp-0x20],rcx
0xfe77b01d6c9    89  48897dd8       REX.W movq [rbp-0x28],rdi
0xfe77b01d6cd    8d  48895dd0       REX.W movq [rbp-0x30],rbx
0xfe77b01d6d1    91  e8aafbffff     call 0xfe77b01d280       ;; wasm stub: WasmStackGuard
0xfe77b01d6d6    96  33d2           xorl rdx,rdx
0xfe77b01d6d8    98  488b45e8       REX.W movq rax,[rbp-0x18]
0xfe77b01d6dc    9c  488b4de0       REX.W movq rcx,[rbp-0x20]
0xfe77b01d6e0    a0  488b7dd8       REX.W movq rdi,[rbp-0x28]
0xfe77b01d6e4    a4  488b75f0       REX.W movq rsi,[rbp-0x10]
0xfe77b01d6e8    a8  488b5dd0       REX.W movq rbx,[rbp-0x30]
0xfe77b01d6ec    ac  eb8f           jmp 0xfe77b01d67d  <+0x3d>
0xfe77b01d6ee    ae  448b462b       movl r8,[rsi+0x2b]
0xfe77b01d6f2    b2  4d03c5         REX.W addq r8,r13
0xfe77b01d6f5    b5  458b4007       movl r8,[r8+0x7]
0xfe77b01d6f9    b9  4d03c5         REX.W addq r8,r13
0xfe77b01d6fc    bc  4c8b4e2f       REX.W movq r9,[rsi+0x2f]
0xfe77b01d700    c0  4d8b09         REX.W movq r9,[r9]
0xfe77b01d703    c3  488945e8       REX.W movq [rbp-0x18],rax
0xfe77b01d707    c7  48894de0       REX.W movq [rbp-0x20],rcx
0xfe77b01d70b    cb  48897dd8       REX.W movq [rbp-0x28],rdi
0xfe77b01d70f    cf  48895dd0       REX.W movq [rbp-0x30],rbx
0xfe77b01d713    d3  4c8bd6         REX.W movq r10,rsi
0xfe77b01d716    d6  498bf0         REX.W movq rsi,r8
0xfe77b01d719    d9  4d8bc2         REX.W movq r8,r10
0xfe77b01d71c    dc  41ffd1         call r9
0xfe77b01d71f    df  33d2           xorl rdx,rdx
0xfe77b01d721    e1  488b45e8       REX.W movq rax,[rbp-0x18]
0xfe77b01d725    e5  488b4de0       REX.W movq rcx,[rbp-0x20]
0xfe77b01d729    e9  488b7dd8       REX.W movq rdi,[rbp-0x28]
0xfe77b01d72d    ed  488b75f0       REX.W movq rsi,[rbp-0x10]
0xfe77b01d731    f1  488b5dd0       REX.W movq rbx,[rbp-0x30]
0xfe77b01d735    f5  e959ffffff     jmp 0xfe77b01d693  <+0x53>
0xfe77b01d73a    fa  90             nop
0xfe77b01d73b    fb  90             nop
```

As you can see the call to `foo()` (`call r9`) is laid out after the rest of the loop code.

As a result, the hinted version runs ~25% faster than the non-hinted one.

Of course real world code is more complex and probably doing some real computation
instead of just adding numbers in a tight loop. The actual performance gain will
depend heavily on the specific code, and how good the assumptions about the likeness
of a branch are.

Techniques like Performance Guided Optimization can also make use of this feature
and provide more precise hints.
