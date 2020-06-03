# WASM SIMD Web Platform explainer

## User benefits
Modern processors support running multiple common computations in a single operation, so that instead of multiplying a number with a number, you can add (or multiply, subtract, etc.) the individual components of a fixed sized vector instead.

##### Scalar operation #####

```
Ax + Bx = Cx
Ay + By = Cy
Az + Bz = Cz
Aw + Bw = Cw
```

##### SIMD Operation of Vector Length 4 #####

`Ax`|`Ay`|`Az`|`Aw`
--|--|--|--

<pre>
            +
</pre>

`Bx`|`By`|`Bz`|`Bw`
--|--|--|--

<pre>
            =
</pre>

`Cx`|`Cy`|`Cz`|`Cw`
--|--|--|--






This feature is called [Single Instruction Multiple Data (SIMD)](https://en.wikipedia.org/wiki/SIMD), and though hardware support exists for vector lengths up to 512 bits, 128-bit SIMD is the most common and is supported across common hardware architectures.

SIMD has driven large speed ups in certain cases such as image manipulation, video encoding/decoding, machine learning, game engines and physics engines etc - with some of these use-cases not being usable without SIMD support, making SIMD support for the web platform essential for achieving near-native speed with certain native applications.

This proposal outlines exposing a commonly available subset of 128-bit SIMD hardware instructions through WebAssembly.

## Design principles
This proposal consists of a portable set of widely used SIMD operations mapping closely to instructions available in modern hardware. The proposal draws heavily on inputs from application developers on the usefulness of the instructions and implementer feedback on performance. 

JavaScript applications can access the SIMD values in WebAssembly module memory indirectly as scalar values through Arraybuffers, and manipulate them using function calls into WebAssembly. The 128-bit values are not currently exposed to JavaScript. There are no known accessibility, security or privacy implications specific to this feature. 

## Prior work
The current proposal builds on top of the [SIMD.js TC39 proposal](https://github.com/tc39/ecmascript_simd), which is no longer under active development. The SIMD.js proposal was abandoned for a few reasons:

* Significant performance cliffs hidden within its high level abstractions making it challenging for real world applications to gain consistent benefits.
* Gains only seen in carefully crafted asm.js code, which is not representative of the majority of JavaScript code in the wild.
* High cost of implementation and optimization in engines that outweighed performance wins.

Most of these were offset by the low level abstractions in WebAssembly, where we observed consistent performance across multiple architectures on real world applications.

## References
[1] GitHub repo: https://github.com/WebAssembly/simd

[2] Proposal directory: https://github.com/WebAssembly/simd/tree/master/proposals/simd

[3] Example usage and demos: https://v8.dev/features/simd

[4] Tests: https://github.com/WebAssembly/simd/tree/master/test/core/simd

[5] External status/issue trackers for this feature: https://www.chromestatus.com/feature/6533147810332672

[6] SIMD.js: https://github.com/tc39/ecmascript_simd 

[7] W3C Tag design reviews - WebAssembly SIMD : https://github.com/w3ctag/design-reviews/issues/487
