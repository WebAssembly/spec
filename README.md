# WebAssembly Specifications

To support the *embedding* of WebAssembly in different environments, its specification is split into *layers* that are specified in separate documents.

* Core specification: defines the semantics of WebAssembly modules and its instruction set, independent from a concrete embedding.
  The WebAssembly core is specified in a single document:

  * [Core](core/): defines the structure of WebAssembly modules and its representation in binary and text format, as well as the semantics of validation, instantiation, and execution.

* API specifications: define *application programming interfaces* enabling the use of WebAssembly modules in concrete embedding environments.
  Currently, two APIs are specified:

  * [JavaScript API](js-api/): defines JavaScript classes and objects for accessing WebAssembly from within JavaScript, including methods for validation, compilation, instantiation, and classes for representing and manipulating imports and exports as JavaScript objects.

  * [Web API](web-api/): defines extensions to the JavaScript API made available specifically in web browsers, in particular, an interface for streaming compilation and instantiation from origin-bound `Response` types.
