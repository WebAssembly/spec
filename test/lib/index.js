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

function assertErrorMessage(f, ctor, test) {
    try {
        f();
    } catch (e) {
        assert_true(e instanceof ctor, "expected exception " + ctor.name + ", got " + e);
        if (typeof test == "string") {
            assert_true(test === e.message, "expected " + test + ", got " + e.message);
        } else {
            assert_true(test.test(e.message), "expected " + test.toString() + ", got " + e.message);
        }
        return;
    }
    assert_true(false, "expected exception " + ctor.name + ", no exception thrown");
};

// Mimick the wasm spec-interpreter test harness.
var spectest = {
    print: console.log.bind(console),
    global: 666,
    table: new WebAssembly.Table({initial: 10, maximum: 20, element: 'anyfunc'}),
    memory: new WebAssembly.Memory({initial: 1, maximum: 2})
};

var registry = { spectest };

function register(name, instance) {
    registry[name] = instance.exports;
}

function module(bytes, valid = true) {
    let buffer = new ArrayBuffer(bytes.length);
    let view = new Uint8Array(buffer);
    for (let i = 0; i < bytes.length; ++i) {
        view[i] = bytes.charCodeAt(i);
    }

    test(() => {
        assert_equals(WebAssembly.validate(buffer), valid);
    }, (valid ? '' : 'in') + 'valid module');

    try {
        return new WebAssembly.Module(buffer);
    } catch(e){
        if (!valid)
            throw e;
        return null;
    }
}

// Proxy used when a module can't be compiled, thus instanciated; this is an
// object that contains any name property, returned as a function.
const AnyExportAsFunction = new Proxy({}, {
    get() {
        return function() {}
    }
});

function instance(bytes, imports = registry) {
    let m = module(bytes);
    if (m === null) {
        test(() => {
            assert_unreached('instance(): unable to compile module');
        });
        return {
            exports: AnyExportAsFunction
        }
    }
    return new WebAssembly.Instance(m, imports);
}

function assert_malformed(bytes) {
    test(() => {
        try {
            module(bytes, false);
        } catch (e) {
            assert_true(e instanceof WebAssembly.CompileError, "expect CompileError in assert_malformed");
            return;
        }
        assert_unreached("assert_malformed: wasm decoding failure expected");
    }, "assert_malformed");
}

const assert_invalid = assert_malformed;

function assert_soft_invalid(bytes) {
    test(() => {
        try {
            module(bytes, /* soft invalid */ false);
        } catch (e) {
            assert_true(e instanceof WebAssembly.CompileError, "expect CompileError in assert_soft_invalid");
            return;
        }
    }, "assert_soft_invalid");
}

function assert_unlinkable(bytes) {
    test(() => {
        let mod = module(bytes);
        if (!mod) {
            assert_unreached('assert_unlinkable: module should have compiled!');
            return;
        }
        try {
            new WebAssembly.Instance(mod, registry);
        } catch (e) {
            assert_true(e instanceof WebAssembly.LinkError, "expect LinkError in assert_unlinkable");
            return;
        }
        assert_unreached("Wasm linking failure expected");
    }, "assert_unlinkable");
}

function assert_uninstantiable(bytes) {
    test(() => {
        let mod = module(bytes);
        if (!mod) {
            assert_unreached('assert_unlinkable: module should have compiled!');
            return;
        }
        try {
            new WebAssembly.Instance(mod, registry);
        } catch (e) {
            assert_true(e instanceof WebAssembly.RuntimeError, "expect RuntimeError in assert_uninstantiable");
            return;
        }
        assert_unreached("Wasm trap expected");
    }, "assert_uninstantiable");
}

function assert_trap(action) {
    test(() => {
        try {
            action()
        } catch (e) {
            assert_true(e instanceof WebAssembly.RuntimeError, "expect RuntimeError in assert_trap");
            return;
        }
        assert_unreached("Wasm trap expected");
    }, "assert_trap");
}

let StackOverflow;
try { (function f() { 1 + f() })() } catch (e) { StackOverflow = e.constructor }

function assert_exhaustion(action) {
    test(() => {
        try {
            action();
        } catch (e) {
            assert_true(e instanceof StackOverflow, "expect StackOverflow in assert_exhaustion");
            return;
        }
        assert_unreached("Wasm resource exhaustion expected");
    }, "assert_exhaustion");
}

function assert_return(action, expected) {
    test(() => {
        let actual = action();
        assert_equals(actual, expected, "Wasm return value " + expected + " expected, got " + actual);
    }, "assert_return");
}

function assert_return_nan(action) {
    test(() => {
        let actual = action();
        assert_true(Number.isNaN(actual), "Wasm return value NaN expected, got " + actual);
    }, "assert_return_nan");
}
