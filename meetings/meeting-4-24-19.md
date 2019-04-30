WebAssembly SIMD Meeting

When: 4/23/2019

Attendees: 
Deepti Gandluri (DG)
Peter Jensen (PJ)
Petr Penzin (PP)
Richard Winterton (RW)
Thomas Lively (TL)
Arun Purushan (AP)
Marat Dukhan (MD)

Agenda: 
SIMD Versioning proposal (Thomas)  https://github.com/WebAssembly/simd/issues/72
C/C++ intrinsics PR at Tool-conventions repo (Rich/Tomas) https://github.com/WebAssembly/tool-conventions/pull/108
SIMD Spec tests
CG F2F Simd topics
Future Meeting timings




Details:
SIMD Versioning proposal (Thomas)  https://github.com/WebAssembly/simd/issues/72
TL: Versioning the proposal will be useful as there are multiple implementations, engines and toolchain. Churn on instructions are implemented/ buggy/ proposed etc.  Early adopters expressed concern about mismatch in expectations.  Toolchain and v8 has some ops missing.  Tag versions of the proposal. Simple and lightweight. Examples: V1 v2 v3 etc saying latest version of llv matches v2 of spec through a tag. Latest version of v8 supports v2 etc. Feedback that proposal v8 centric. Can be changed. Looking for more feedback.
AP: There seems to be some precedence to this from JS. We need to consider that. Agree that implementer references needs to be taken out. Timing to start was an open. Suggest we start when the implementations catch up rather than dropping instr.
DG: Replace v8 with any implementor. Disagree to wait for implementor to catch up. Sooner is better. Ran into Dan Ernberg and had precedence to try to version based on spec version. Unclear on the issues, ccd him and we should await feedback.
TL: Waiting is nice but, Sooner is better. V8 might not be implementing i64/f64 soon. Waiting for v8 to catch up is saying we are not going to version. Wouldnt Make sense to chakra and v8 to point to the same version as they dont implement the same. May be versions dont need to be linear order. Create a tag in the repo <v8-1, v8-2> etc..
DG: May be it makes sense to stay away from implementer based tag. Implementor agnostic tag will be useful. 64x2 is yet to see test cases or use cases asking for it. Not sure if its a useful subset or not. 
TL: Users might want to match toolchain-engine-doc. If different engine implement different subset, useful to have separate tags for separate subsets. 
DG: Agree that we need different tags. Spec needs to be implementation agnostic. Users should be able to look up this info in a document may beThe details can reside in other documentation. Doesn't necessarily need to happen in the spec. v8/chakra release notes with ref to tags is better. Spec shouldnt have any implementation ref. 
TL: Maybe we don't need to modify the spec at all, just have documentation capturing the support info.
DG: As long as we agree on what doc looks like, we dont need to version the spec. Versioning makes sense witht the branches. We need to have more conversations. For the time being we can have a document.
RW: As long as there is a mapping from implementers to the spec, that would do. As long as we can have a mapping to what's implemented, its useful. Ie. color scheme/venn diagram  with versioning somewhere in the document.
TL: what if we check in a markdown file big table updated by all implementers. Ultra lightweight. 
<Everyone agrees>
AR: Tomas will create a PR with a V8 column. Arun/Petr update chakra column. 
DG: has chakra implementation been tested?
PP: Tested against its own tests with wabt . Toolchain some experiments on going.
DG: Tomas has exhaustive tests on simd. May be its a good idea to run them in chakra.
RW: Its in the emscripten tests already. May be we can add intrinsics too. 
TL : New Emscripten PR to add test mode for simd. Able to run entire emscriten test suite with simd enabled once it lands. I will cc some of you on that PR. 
AP: OK, we will pick it up and test against chakra. 


C/C++ intrinsics PR at Tool-conventions repo (Rich/Tomas) https://github.com/WebAssembly/tool-conventions/pull/108
RW: Pretty much covered. Belongs in emscripten at some point. Probably could move over to clang. Open question is where does it reside long term, in Clang or Emscripten? We can move over to clang in some point in future.
TL: Are there any wasm pre existing headers in Clang? 
PP: No, not yet. This is simd128, wasm will have more ops.  Also, there are WASM memory operations that would need intrinsics at some point. Should those be in a separate header?
TL: We have compiler builtins for that stuff. No one has made any intrinsics TMK. That could go in there too. We might want separate header for them. Makes sense to keep simd intrinsics separate from memory intrinsics. 
PP: Another difference bw emscripten and clang is clang doesn’t include tests for the intrinsics, only for builtins. 
TL: Clang tests are compiled but not executed, they only check that code is produced. That is why I want the libs folder. directory with headers. We might need to have them in both places.
AP: Why is this needed to be duplicated? 
TL: Not sure emscripten going to use clang headers, it will use its own libc. 
AP: Why emscripten is not using it?
RW: If you use emscripten sdk you not going to get all clang headers with it. 
TL: Switching to llvm backend in emscripten, once we have headers in clang, there will be an incentive to use clang headers. We might need to duplicate for now. 
PP: What is the difference between clang in emscripten. Fastcom clang and actual.
TL: Fastcom is not based on trunk llvm, old llvm. And it has fastcomp backend compiles directly to llvm ir to js. It doesn't know anything about wasm. It transfers to asm js and then wasm. Working on deprecating that. 
RW: To get simd support in Emscripten we have to pull down simd branch Tomas created. 
TL: SIMD doesn't work with fastcomp. It works with the new backend. 
TL: WASM simd intrinsics are not merged to upstream yet. If you just use emscripten from emsdk, it uses fastcomp and does not support simd at all. 

SIMD Spec tests
AP: We discussed internally and we might be able to help with simd spec tests
DG: Any help will be appreciated. Google already working on toolchain and implementation and this will help to move the proposal forward quicker. Do you have a timeline on when it can be started. 
AP: Need to get back to you on this. They are already doing work on core spec and RW’s intrinsics. Need to sync and find out. 
DG: Sounds good. Really encouraging to see you might be able to help. After the in person meeting, we will start looking into some of these. There is enough work, we can work together. We have ref interpreter work and spec tests. We can collaborate.
CG F2F Simd topics
AP: Any simd topics to discuss at the F2F forum. Can we push for stage 2? Anything else that we need to be prepared with.
DG: we are trying to get some FP numbers. So that we will include those in the spec tests. Confident that it is possible. Add agenda to simd proposal as an update to the simd proposal. Goal is pushing to Stage2. Who is attending?
AP:  not confirmed yet.
PJ: Not going?
DG: I should be going.  Sharing simd stuff there. 
TL: will attend. 
RW: Not attending. 
PP: FP numbers ? We will think about getting some numbers. 
DG: It  was the feedback that we got from the community. We had integer data from Webp is a codec team at google. 
AR: We may be able to look into some chakra data as well. 
PP: Will consider it.
MD: Lack of FMA in simd proposal is a concern for ML applications. It can hit pref upto 2x
DG: WebP team has the same feedback. We are considering to add it. If you can put together a pr with results we will be happy to review that. 
PP: We can prototype it.
MD: Did my basic experiemnts and there is significant speedup. 
RW: I want to add sign extend and load extend.
DG: Please create a PR
AR: Rich to create a PR
MD: There is not a simple way to sore parts of a simd reg. Ie store only in 64bit simd, in wasm it needs to be done in a roundabout way. 
RW: you want to store partial registers right?
MD: yes. Currently it can be done only through extract.
DG: Do you know how useful it is and how much overhead is causing?
MD: We use it often, hard to quantify impact. Prefer to have these explicitly. 
PJ: SImdjs had load1, load2 load3 etc for partial load and store.
DG: Yes.
RW: Dont know the history of why we only wanted 128. Else we can just propose it. We seems to have a new list to add
DG: FMA already has an issue, load extension RW to follow up. We cna have a new issue for partial stores and loads.
Future Meeting timings
DG: Didnt hear from people in EU time zone with interest. Current slot seems to work for now. Let's continue until this is needed.

Open:
RW: Fyi for TL . requested help with tianyou’s team with validation. 


