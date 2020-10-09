# Branch hinting

## Introduction

### Motivation

The primary motivations are:


### Background

This proposal has first been presented here:

https://github.com/WebAssembly/design/issues/1363

This topic was preliminarily discussed at the CG-09-29 meeting:

https://github.com/WebAssembly/meetings/blob/master/main/2020/CG-09-29.md

The consensus seems to be to proceed with the idea, but to present some benchmarks
to prove the need for the proposal (see [here](benchmarks)).

This repo contains the current work toward a spec, and the benchmarks.

### Design

This proposal introduces 1 new instruction:

 - `branch_hint`

The semantic...
### Encoding

The encoding for the new instruction is the following:

| Name | Opcode | Immediate | Description |
| ---- | ---- | ---- | ---- |
| `branch_hint` | `0xXX` | | branch hinting |
