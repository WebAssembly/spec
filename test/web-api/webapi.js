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
(function testWebAPI() {
    const incrementer_url = '../wasm/incrementor.wasm';
    const invalid_wasm_url = '../wasm/invalid-wasm.wasm';

    const AssertType = (obj, type) => assert_equals(obj.constructor, type);
    
    const AssertTypeError = obj => AssertType(obj, TypeError);

    const AssertCompileError = obj => AssertType(obj, WebAssembly.CompileError);
    
    const buildImportingModuleBytes = () => {
        const builder = new WasmModuleBuilder();
        builder.addImportedMemory("", "memory", 1);
        const kSig_v_i = makeSig([kWasmI32], []);
        const signature = builder.addType(kSig_v_i);
        builder.addImport("", "some_value", kSig_i_v);
        builder.addImport("", "writer", signature);
        
        builder.addFunction("main", kSig_i_i)
            .addBody([
            kExprGetLocal, 0,
            kExprI32LoadMem, 0, 0,
            kExprI32Const, 1,
            kExprCallIndirect, signature, kTableZero,
            kExprGetLocal,0,
            kExprI32LoadMem,0, 0,
            kExprCallFunction, 0,
            kExprI32Add
            ]).exportFunc();
        
        // writer(mem[i]);
        // return mem[i] + some_value();
        builder.addFunction("_wrap_writer", signature)
            .addBody([
            kExprGetLocal, 0,
            kExprCallFunction, 1]);
        builder.appendToTable([2, 3]);
        
        const wire_bytes = builder.toBuffer();
        return new Response(wire_bytes, {headers:{"Content-Type":"application/wasm"}});
    }
      
    test(() => {
        fetch(incrementer_url)
            .then(WebAssembly.compileStreaming)
            .then(m => new WebAssembly.Instance(m))
            .then(i => assert_equals(5, i.exports.increment(4)));
    }, "Test streamed Compile");

    test(() => {
        fetch(incrementer_url)
            .then(WebAssembly.compileStreaming)
            .then(assert_unreached, AssertTypeError);
    }, "Compile mime type is checked");

    test(() => {
        fetch(incrementer_url)
            .then(WebAssembly.instantiateStreaming)
            .then(assert_unreached, AssertTypeError);
    }, "Instantiate mime type is checked");

    test(() => {
        WebAssembly.compileStreaming(fetch(incrementer_url))
            .then(m => new WebAssembly.Instance(m))
            .then(i => assert_equals(5, i.exports.increment(4)));
    }, "Short form streamed Compile");

    test(() => {
        WebAssembly.compileStreaming(Promise.resolve(5))
            .then(assert_unreached, AssertTypeError);
    }, "Negative streamed compile promise");

    test(() => {
        WebAssembly.compileStreaming(new Response())
            .then(assert_unreached, AssertTypeError);
    }, "Compile blank response");

    test(() => {
        WebAssembly.instantiateStreaming(new Response())
            .then(assert_unreached, AssertTypeError);
    }, "Instantiate blank response");

    test(() => {
        WebAssembly.compileStreaming()
            .then(assert_unreached, AssertTypeError);
    }, "Compile empty");

    test(() => {
        WebAssembly.instantiateStreaming()
            .then(assert_unreached, AssertTypeError);
    }, "Instantiate empty");

    test(() => {
        fetch(incrementer_url)
            .then(r => r.arrayBuffer())
            .then(arr => new Response(arr, {headers:{"Content-Type":"application/wasm"}}))
            .then(WebAssembly.compileStreaming)
            .then(m => new WebAssembly.Instance(m))
            .then(i => assert_equals(6, i.exports.increment(5)));
    }, "Compile from array buffer");

    test(() => {
        const arr = new ArrayBuffer(10);
        const view = new Uint8Array(arr);
        for (let i = 0; i < view.length; ++i) view[i] = i;
      
        return WebAssembly.compileStreaming(new Response(arr))
          .then(assert_unreached, AssertTypeError);
    }, "Compile from invalid array buffer");

    test(() => {
        const arr = new ArrayBuffer(10);
        const view = new Uint8Array(arr);
        for (let i = 0; i < view.length; ++i) view[i] = i;
      
        return WebAssembly.instantiateStreaming(new Response(arr))
            .then(assert_unreached, AssertTypeError);
    }, "Instantiate from invalid array buffer");

    test(() => {        
        return fetch(incrementer_url)
            .then(response => response.arrayBuffer())
            .then(WebAssembly.instantiateStreaming)
            .then(assert_unreached, AssertTypeError);
    }, "Instantiate from array buffer");

    test(() => {        
        return WebAssembly.instantiateStreaming(fetch(incrementer_url))
            .then(pair => assert_equals(5, pair.instance.exports.increment(4)));
    }, "Short form streamed instantiate");

    test(() => {        
        return fetch(incrementer_url)
            .then(response => response.arrayBuffer())
            .then(WebAssembly.instantiateStreaming)
            .then(assert_unreached, AssertTypeError);
    }, "Instantiate from array buffer");

    test(() => {        
        return fetch(incrementer_url)
            .then(response => response.arrayBuffer())
            .then(WebAssembly.instantiateStreaming)
            .then(assert_unreached, AssertTypeError);
    }, "Instantiate from array buffer");

    test(() => {
        const mem_1 = new WebAssembly.Memory({initial: 1});
        const view_1 = new Int32Array(mem_1.buffer);
        view_1[0] = 42;
        let outval_1;
      
        const ffi = {"":
                   {some_value: () => 1,
                    writer: (x) => outval_1 = x ,
                    memory: mem_1}
                  };
        return Promise.resolve(buildImportingModuleBytes())
          .then(b => WebAssembly.instantiateStreaming(b, ffi))
          .then(pair => AssertType(pair.instance, WebAssembly.Instance));
      }, "Instantiate complex module");
      
      test (() => {
        return WebAssembly.compileStreaming(fetch(invalid_wasm_url))
          .then(assert_unreached,
                AssertCompileError);
      }, "Compile from invalid download");
      
      test (() => {
        return WebAssembly.instantiateStreaming(fetch(invalid_wasm_url))
          .then(assert_unreached,
                AssertCompileError);
      }, "Instantiate from invalid download");
      
      test (() => {
        let resolve;
        // Create a promise which fulfills when the worker finishes.
        let promise = new Promise(function(res, rej) {
          resolve = res;
        });
      
        let blobURL = URL.createObjectURL(new Blob(
            [
              '(',
              function() {
                // Return true if the WebAssembly.compileStreaming exists.
                // WebAssembly.compileStreaming is not executed on the worker because
                // fetch() does not work on a worker. It just causes a timeout.
                self.postMessage(typeof WebAssembly.compileStreaming !== "undefined");
              }.toString(),
              ')()'
            ],
            {type: 'application/javascript'}));
      
        let worker = new Worker(blobURL);
        worker.addEventListener('message', e => resolve(e.data));
        return promise.then(exists => assert_true(exists));
      }, "Streaming compile exists in worker");
      
      test (() => {
        let resolve;
        // Create a promise which fulfills when the worker finishes.
        let promise = new Promise(function(res, rej) {
          resolve = res;
        });
      
        let blobURL = URL.createObjectURL(new Blob(
            [
              '(',
              function() {
                // Return true if the WebAssembly.instantiateStreaming exists.
                // WebAssembly.instantiateStreaming is not executed on the worker because
                // fetch() does not work on a worker. It just causes a timeout.
                self.postMessage(typeof WebAssembly.instantiateStreaming !== "undefined");
              }.toString(),
              ')()'
            ],
            {type: 'application/javascript'}));
      
        let worker = new Worker(blobURL);
        worker.addEventListener('message', e => resolve(e.data));
        return promise.then(exists => assert_true(exists));
      }, "Streaming instantiate exists in worker");
})();
    