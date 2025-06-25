# Entropy, Compat and Usage patterns

The Relaxed SIMD proposal adds new operations that take advantage of the underlying hardware for accelerated performance by loosening the portability constraints of fixed-width SIMD, or adding new instructions that introduce local non-determinisim. This introduces a few potential risks specifically for browser engine implementations, though it’s possible that one or more of these might be applicable to other environments: 
* Identifying underlying characteristics of the device (processor information if the engine that implements this proposal used the most optimal lowerings)
* Possibly identifying information about the browser currently in use (i.e. if a sufficiently motivated user writes a hand tuned Wasm function when engines use different lowerings for instructions)
* Compatibility risks, i.e. if code compiled for one browser works differently on a different browser (This is specific to observable behavior changes, and not performance differences)

This document is an attempt to collate information that is already available in the issues filed for each of the operations on fingerprinting risk, quantify the risk for fingerprinting/compat issues and provide some information about usage patterns. 

## Instruction summary

* **relaxed i8x16.swizzle**<br>
  *Entropy exposed:* Differences between x86/ARM<br>
  *Deterministic lowering:* Available<br>
  *Compat risk:* Low, as the differences exposed are for out of range indices<br>
  [*Issue link*](https://github.com/WebAssembly/relaxed-simd/issues/22)
* **relaxed i32x4.trunc_{f32x4, f64x2} operations**<br>
  *Entropy exposed:* Differences between x86/ARM<br>
  *Deterministic lowering:* Available<br>
  *Compat risk:* Low, as the differing behavior is for out of range values, and NaNs<br>
  [*Issue link*](https://github.com/WebAssembly/relaxed-simd/issues/21)<br>
* **qfma, qfmns**<br>
  *Entropy exposed:* Differences between hardware that has native FMA support, and hardware that does not.<br>
  *Deterministic lowering:* Not available, but depending on underlying hardware, the results can only be fused, or unfused.<br>
  *Compat risk:* Potentially divergent behavior based on hardware FMA support<br>
  *Mitigating reasons to include:* Most modern hardware do have native FMA support, performance wins are significant, operations are difficult to emulate<br>
  [*Issue link*](https://github.com/WebAssembly/simd/pull/79)<br>
* **{i8x16, i16x8, i32x4, i64x2}.laneselect**<br>
  *Entropy exposed:* x86/ARM<br>
  *Deterministic lowering:* Available<br>
  *Compat risk:* Medium, architectures vary on which bit is used for lane selection<br>
  [*Issue link*](https://github.com/WebAssembly/relaxed-simd/issues/17)<br>
* **{f32x4, f64x2}.{min,max}**<br>
  *Entropy exposed:* x86/ARM<br>
  *Deterministic lowering:* Available<br>
  *Compat risk:* Low, varying outputs when one of the inputs is NaN, or  +0, -0<br>
  [*Issue link*](https://github.com/WebAssembly/relaxed-simd/issues/33)<br>
* **I16x8.relaxed_q15mulr_s**<br>
  *Entropy exposed:* x86/ARM<br>
  *Deterministic lowering:* Available<br>
  *Compat risk:* Low, different behaviors only in the overflow case<br>
  [*Issue link*](https://github.com/WebAssembly/relaxed-simd/issues/40)<br>
* **Dot product instructions**<br>
  *Entropy exposed:* x86/ARM, and whether the Dot product extension is supported in the most optimal codegen<br>
  *Deterministic lowering:* Available, but only when not using the most optimal codegen<br>
  *Compat risk:* Medium for architectures that support the Dot product extensions as they vary in saturating/wrapping behavior of intermediate results<br>   *Mitigating reasons to include:* [Performance](https://docs.google.com/presentation/d/1xlyO1ly2Fbo2Up5ZuV_BTSwiNpCwPygag09XQRjclSA/edit#slide=id.g1fee95a4c4f_0_0)<br>
  [*Issue link*](https://github.com/WebAssembly/relaxed-simd/issues/52)

## Usage patterns

One of the things to note here, for compat especially, is to lay out the usage patterns, or specifically when these instructions are generated. As the proposal is still in the experimental state, the only way to currently experiment with these instructions are to call the clang built-ins directly, and experiment with them on an engine that has these instructions available as a prototype. 

In the future, these can be invoked using:
 * Wasm Intrinsic header files
 * Possibly in the autovectorizer, but only when flags like `-ffast-math` are used, that assume inputs and/or results are not NaNs or +-Infs.

The thing to note here is that by either explicitly calling the intrinsics, or using specific compiler flags is a high enough threshold that this type of local non-determinism is not something a user would encounter by default, i.e. these instructions can only be used deliberately, and the proposal assumes a specialized usage.
