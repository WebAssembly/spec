/*
 * Copyright 2017 WebAssembly Community Group participants
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
*/

'use strict';



let testNum = (function() {
    let count = 1;
    return function() {
        return `#${count++} `;
    }
})();

// WPT's assert_throw uses a list of predefined, hardcoded known errors. Since
// it is not aware of the WebAssembly error types (yet), implement our own
// version.
function assertThrows(func, err) {
    let caught = false;
    try {
        func();
    } catch(e) {
        assert_true(e instanceof err, `expected ${err.name}, observed ${e.constructor.name}`);
        caught = true;
    }
    assert_true(caught, testNum() + "assertThrows must catch any error.")
}

/******************************************************************************
***************************** WAST HARNESS ************************************
******************************************************************************/

// For assertions internal to our test harness.
function _assert(x) {
    if (!x) {
        throw new Error(`Assertion failure: ${x}`);
    }
}

// A simple sum type that can either be a valid Value or an Error.
function Result(type, maybeValue) {
    this.value = maybeValue;
    this.type = type;
};

Result.VALUE = 'VALUE';
Result.ERROR = 'ERROR';

function ValueResult(val) { return new Result(Result.VALUE, val); }
function ErrorResult(err) { return new Result(Result.ERROR, err); }

Result.prototype.isError = function() { return this.type === Result.ERROR; }

const EXPECT_INVALID = false;

/* DATA **********************************************************************/

let $$;

// Default imports.
var registry = {};

let chain = Promise.resolve();

// Resets the registry between two different WPT tests.
function reinitializeRegistry() {
  promise_test(_ => chain, testNum() + "reinitializeRegistry");
    if (typeof WebAssembly === 'undefined')
        return;

    registry = {
        spectest: {
            print: console.log.bind(console),
            print_i32: console.log.bind(console),
            print_i32_f32: console.log.bind(console),
            print_f64_f64: console.log.bind(console),
            print_f32: console.log.bind(console),
            print_f64: console.log.bind(console),
            global_i32: 666,
            global_f32: 666,
            global_f64: 666,
            table: new WebAssembly.Table({initial: 10, maximum: 20, element: 'anyfunc'}),
            memory: new WebAssembly.Memory({initial: 1, maximum: 2})
        }
    };
}

reinitializeRegistry();

/* WAST POLYFILL *************************************************************/

function binary(bytes) {
    let buffer = new ArrayBuffer(bytes.length);
    let view = new Uint8Array(buffer);
    for (let i = 0; i < bytes.length; ++i) {
        view[i] = bytes.charCodeAt(i);
    }
    return buffer;
}

/**
 * Returns a compiled module, or throws if there was an error at compilation.
 */
// function module(bytes, valid = true) {
//     let buffer = binary(bytes);
//     let validated;
// 
//     try {
//         validated = WebAssembly.validate(buffer);
//     } catch (e) {
//         throw new Error(`WebAssembly.validate throws ${typeof e}: ${e}${e.stack}`);
//     }
// 
//     if (validated !== valid) {
//         // Try to get a more precise error message from the WebAssembly.CompileError.
//         try {
//             new WebAssembly.Module(buffer);
//         } catch (e) {
//             if (e instanceof WebAssembly.CompileError)
//                 throw new WebAssembly.CompileError(`WebAssembly.validate error: ${e.toString()}${e.stack}\n`);
//             else
//                 throw new Error(`WebAssembly.validate throws ${typeof e}: ${e}${e.stack}`);
//         }
//         throw new Error(`WebAssembly.validate was expected to fail, but didn't`);
//     }
// 
//     let module;
//     try {
//         module = new WebAssembly.Module(buffer);
//     } catch(e) {
//         if (valid)
//             throw new Error('WebAssembly.Module ctor unexpectedly throws ${typeof e}: ${e}${e.stack}');
//         throw e;
//     }
// 
//     return module;
// }

function uniqueTest(func, desc) {
    test(func, testNum() + desc);
}

function module(bytes, valid = true) {
  let buffer = binary(bytes);
  let validated = WebAssembly.validate(buffer);

  uniqueTest(_ => {
    assert_equals(valid, validated, "WebAssembly.validate did not produce the expected result");
  }, "validate");

  chain = chain.then(_ => WebAssembly.compile(buffer)).then(module => {
    uniqueTest(_ => {
      assert_true(valid, "WebAssembly.compile was supposed to fail");
    }, "module");
    return module;
  },
  error => {
    uniqueTest(_ => {
      assert_true(!valid, `WebAssembly.compile was supposed to succeed but failed with ${error}`);
    }, "module");
  });
}

function assert_invalid(bytes) {
  module(bytes, /* valid */ false);
}

const assert_malformed = assert_invalid;

function instance(bytes, imports = registry, valid = true) {
  chain = Promise.all([imports, chain]).then(values =>
    WebAssembly.instantiate(binary(bytes), values[0])).then(
      pair => {
        uniqueTest(_ => {
          assert_true(valid)
        }, "instance");
        return pair.instance;
      },
      error => {
        if (!valid) {
          return error;
        } else {
          throw error;
        }
      });
  return chain;
}

function exports(name, instance) {
  return instance.then(inst => {
    return { [name]: inst.exports };
  });
}

function call(instance, name, args) {
  let stack = new Error();
  return instance.then(inst => inst.exports[name](...args));
};

function run(action) {
  let stack = new Error();
  chain = Promise.all([chain, action()]).then(_ => {
    uniqueTest(_ => {
    }, "run " + stack.stack)
  },
  error => {
    uniqueTest(_ => {
      assert_true(false, `unexpected runtime error, observed ${error}\n${stack.stack}\n\n`);
    }, "run");
  }).catch(_ => {});
}

function assert_trap(action) {
  chain = Promise.all([chain, action()]).then(result => {
    uniqueTest(_ => {
      assert_true(false, 'expected a WebAssembly trap');
    }, "assert_trap");
  },
  error => {
    uniqueTest(_ => {
      assert_true(error instanceof WebAssembly.RuntimeError,
          `expected runtime error, observed ${error}:`);
    }, "assert_trap");
  }).catch(_ => {});
}

function assert_return(action, expected) {
  chain = Promise.all([action(), chain]).then(values => {
    uniqueTest(_ => {
      assert_equals(values[0], expected);
    }, "assert_return");
  },
  error => {
    uniqueTest(_ => {
      assert_true(false, `unexpected runtime error, observed ${error}`);
    }, "assert_return");
  }).catch(_=> {});
}

let StackOverflow;
try { (function f() { 1 + f() })() } catch (e) { StackOverflow = e.constructor }

function assert_exhaustion(action) {
  chain = action().then(result => {
    uniqueTest(_ => {
      assert_true(false, 'expected a WebAssembly trap');
    }, "assert_exhaustion");
  },
  error => {
    uniqueTest(_ => {
      assert_true(error instanceof StackOverflow,
          `expected runtime error, observed ${error}:`);
    }, "assert_trap");
  }).catch(_=>{});
}

function assert_unlinkable(bytes) {
  instance(bytes, registry, EXPECT_INVALID).then(result => {
    uniqueTest(_ => {
      assert_true(false, 'expected a WebAssembly.LinkError');
    }, "assert_unlinkable");
  },
  error => {
    uniqueTest(_ => {
      assert_true(error instanceof WebAssembly.LinkError,
          `expected link error, observed ${error}:`);
    }, "assert_unlinkable");
  });

    let result = instance(bytes, registry, EXPECT_INVALID);

    _assert(result instanceof Result);

    uniqueTest(() => {
        assert_true(result.isError(), 'expected error result');
        if (result.isError()) {
            let e = result.value;
            assert_true(e instanceof WebAssembly.LinkError, `expected link error, observed ${e}:`);
        }
    }, "A wast module that is unlinkable.");
}

// function instance(bytes, imports = registry, valid = true) {
//     if (imports instanceof Result) {
//         if (imports.isError())
//             return imports;
//         imports = imports.value;
//     }
//
//     let err = null;
//
//     let m, i;
//     try {
//         let m = module(bytes);
//         i = new WebAssembly.Instance(m, imports);
//     } catch(e) {
//         err = e;
//     }
//
//     if (valid) {
//         uniqueTest(() => {
//             let instantiated = err === null;
//             assert_true(instantiated, err);
//         }, "module successfully instantiated");
//     }
//
//     return err !== null ? ErrorResult(err) : ValueResult(i);
// }
//
// function register(name, instance) {
//     _assert(instance instanceof Result);
//
//     if (instance.isError())
//         return;
//
//     registry[name] = instance.value.exports;
// }
//
// function get(instance, name) {
//     _assert(instance instanceof Result);
//
//     if (instance.isError())
//         return instance;
//
//     return ValueResult(instance.value.exports[name]);
// }
//
// function exports(name, instance) {
//     _assert(instance instanceof Result);
//
//     if (instance.isError())
//         return instance;
//
//     return ValueResult({ [name]: instance.value.exports });
// }
//
// function run(action) {
//     let result = action();
//
//     _assert(result instanceof Result);
//
//     uniqueTest(() => {
//         if (result.isError())
//             throw result.value;
//     }, "A wast test that runs without any special assertion.");
// }
//
// function assert_unlinkable(bytes) {
//     let result = instance(bytes, registry, EXPECT_INVALID);
//
//     _assert(result instanceof Result);
//
//     uniqueTest(() => {
//         assert_true(result.isError(), 'expected error result');
//         if (result.isError()) {
//             let e = result.value;
//             assert_true(e instanceof WebAssembly.LinkError, `expected link error, observed ${e}:`);
//         }
//     }, "A wast module that is unlinkable.");
// }
//
// function assert_uninstantiable(bytes) {
//     let result = instance(bytes, registry, EXPECT_INVALID);
//
//     _assert(result instanceof Result);
//
//     uniqueTest(() => {
//         assert_true(result.isError(), 'expected error result');
//         if (result.isError()) {
//             let e = result.value;
//             assert_true(e instanceof WebAssembly.RuntimeError, `expected runtime error, observed ${e}:`);
//         }
//     }, "A wast module that is uninstantiable.");
// }
//
// function assert_trap(action) {
//     let result = action();
//
//     _assert(result instanceof Result);
//
//     uniqueTest(() => {
//         assert_true(result.isError(), 'expected error result');
//         if (result.isError()) {
//             let e = result.value;
//             assert_true(e instanceof WebAssembly.RuntimeError, `expected runtime error, observed ${e}:`);
//         }
//     }, "A wast module that must trap at runtime.");
// }
//
// let StackOverflow;
// try { (function f() { 1 + f() })() } catch (e) { StackOverflow = e.constructor }
//
// function assert_exhaustion(action) {
//     let result = action();
//
//     _assert(result instanceof Result);
//
//     uniqueTest(() => {
//         assert_true(result.isError(), 'expected error result');
//         if (result.isError()) {
//             let e = result.value;
//             assert_true(e instanceof StackOverflow, `expected stack overflow error, observed ${e}:`);
//         }
//     }, "A wast module that must exhaust the stack space.");
// }
//
// function assert_return(action, expected) {
//     if (expected instanceof Result) {
//         if (expected.isError())
//             return;
//         expected = expected.value;
//     }
//
//     let result = action();
//
//     _assert(result instanceof Result);
//
//     uniqueTest(() => {
//         assert_true(!result.isError(), `expected success result, got: ${result.value}.`);
//         if (!result.isError()) {
//             assert_equals(result.value, expected);
//         };
//     }, "A wast module that must return a particular value.");
// };
//
// function assert_return_nan(action) {
//     let result = action();
//
//     _assert(result instanceof Result);
//
//     uniqueTest(() => {
//         assert_true(!result.isError(), 'expected success result');
//         if (!result.isError()) {
//             assert_true(Number.isNaN(result.value), `expected NaN, observed ${result.value}.`);
//         };
//     }, "A wast module that must return NaN.");
// }
