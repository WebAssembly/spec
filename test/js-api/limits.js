/*
 * Copyright 2018 WebAssembly Community Group participants
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

let kJSEmbeddingMaxTypes = 1000000;
let kJSEmbeddingMaxFunctions = 1000000;
let kJSEmbeddingMaxImports = 100000;
let kJSEmbeddingMaxExports = 100000;
let kJSEmbeddingMaxGlobals = 1000000;
let kJSEmbeddingMaxDataSegments = 100000;

let kJSEmbeddingMaxMemoryPages = 32767;  // ~ 2 GiB
let kJSEmbeddingMaxModuleSize = 1024 * 1024 * 1024;  // = 1 GiB
let kJSEmbeddingMaxFunctionSize = 7654321;
let kJSEmbeddingMaxFunctionLocals = 50000;
let kJSEmbeddingMaxFunctionParams = 1000;
let kJSEmbeddingMaxFunctionReturns = 1;
let kJSEmbeddingMaxTableSize = 10000000;
let kJSEmbeddingMaxTableEntries = 10000000;
let kJSEmbeddingMaxTables = 1;
let kJSEmbeddingMaxMemories = 1;

if (typeof(assert_equals) != "function" && typeof(assertEquals) == "function") {
  // TODO(titzer): local standalone hack
  assert_equals = assertEquals;
}

function testLimit(name, min, limit, gen) {
    print("test max " + name + " = " + limit);
    function run(count) {
        var expected = (count <= limit) ? "(expect ok)  " : "(expect fail)";
        print("  " + expected + " " + count + "...");
        // TODO(titzer): the builder is pretty inefficient for large modules; do manually?
        let builder = new WasmModuleBuilder();
        gen(builder, count);
        return WebAssembly.validate(builder.toBuffer());
    }
    assert_equals(true, run(min));
    assert_equals(true, run(limit));
    assert_equals(false, run(limit+1));
}

// A little doodad to disable a test easily
let DISABLED = {testLimit: () => 0};
let X = DISABLED;

testLimit("types", 1, kJSEmbeddingMaxTypes, (builder, count) => {
        for (let i = 0; i < count; i++) {
            builder.addType(kSig_i_i);
        }
    });

testLimit("functions", 1, kJSEmbeddingMaxFunctions, (builder, count) => {
        let type = builder.addType(kSig_v_v);
        let body = [];
        for (let i = 0; i < count; i++) {
            builder.addFunction(/*name=*/ undefined, type).addBody(body);
        }
    });

testLimit("imports", 1, kJSEmbeddingMaxImports, (builder, count) => {
        let type = builder.addType(kSig_v_v);
        for (let i = 0; i < count; i++) {
            builder.addImport("", "", type);
        }
    });

testLimit("exports", 1, kJSEmbeddingMaxExports, (builder, count) => {
        let type = builder.addType(kSig_v_v);
        let f = builder.addFunction(/*name=*/ undefined, type);
        f.addBody([]);
        for (let i = 0; i < count; i++) {
            builder.addExport("f" + i, f.index);
        }
    });

testLimit("globals", 1, kJSEmbeddingMaxGlobals, (builder, count) => {
        for (let i = 0; i < count; i++) {
            builder.addGlobal(kWasmI32, true);
        }
    });

testLimit("data segments", 1, kJSEmbeddingMaxDataSegments, (builder, count) => {
        let data = [];
        builder.addMemory(1, 1, false, false);
        for (let i = 0; i < count; i++) {
            builder.addDataSegment(0, data);
        }
    });

testLimit("memory pages", 1, kJSEmbeddingMaxMemoryPages, (builder, count) => {
        builder.addMemory(count, count, false, false);
    });

// TODO(titzer): ugh, that's hard to test.
DISABLED.testLimit("module size", 1, kJSEmbeddingMaxModuleSize, (builder, count) => {
    });

testLimit("function size", 2, kJSEmbeddingMaxFunctionSize, (builder, count) => {
        let type = builder.addType(kSig_v_v);
        let nops = count-2;
        let array = new Array(nops);
        for (let i = 0; i < nops; i++) array[i] = kExprNop;
        builder.addFunction(undefined, type).addBody(array);
    });

testLimit("function locals", 1, kJSEmbeddingMaxFunctionLocals, (builder, count) => {
        let type = builder.addType(kSig_v_v);
        builder.addFunction(undefined, type)
          .addLocals({i32_count: count})
          .addBody([]);
    });

testLimit("function params", 1, kJSEmbeddingMaxFunctionParams, (builder, count) => {
        let array = new Array(count);
        for (let i = 0; i < count; i++) array[i] = kWasmI32;
        let type = builder.addType({params: array, results: []});
    });

testLimit("function returns", 0, kJSEmbeddingMaxFunctionReturns, (builder, count) => {
        let array = new Array(count);
        for (let i = 0; i < count; i++) array[i] = kWasmI32;
        let type = builder.addType({params: [], results: array});
    });

testLimit("table size", 1, kJSEmbeddingMaxTableSize, (builder, count) => {
        builder.setFunctionTableBounds(count, count);
    });

testLimit("table entries", 1, kJSEmbeddingMaxTableEntries, (builder, count) => {
        builder.setFunctionTableBounds(1, 1);
        let array = [];
        for (let i = 0; i < count; i++) {
            builder.addFunctionTableInit(0, false, array, false);
        }
    });

testLimit("tables", 0, kJSEmbeddingMaxTables, (builder, count) => {
        for (let i = 0; i < count; i++) {
            builder.addImportedTable("", "", 1, 1);
        }
    });

testLimit("memories", 0, kJSEmbeddingMaxMemories, (builder, count) => {
        for (let i = 0; i < count; i++) {
            builder.addImportedMemory("", "", 1, 1, false);
        }
    });
