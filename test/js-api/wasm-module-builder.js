// Copyright 2016 the V8 project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Used for encoding f32 and double constants to bits.
let __buffer = new ArrayBuffer(8);
let byte_view = new Int8Array(__buffer);
let f32_view = new Float32Array(__buffer);
let f64_view = new Float64Array(__buffer);

function bytes() {
  var buffer = new ArrayBuffer(arguments.length);
  var view = new Uint8Array(buffer);
  for (var i = 0; i < arguments.length; i++) {
    var val = arguments[i];
    if ((typeof val) == "string") val = val.charCodeAt(0);
    view[i] = val | 0;
  }
  return buffer;
}

// Header declaration constants
var kWasmH0 = 0;
var kWasmH1 = 0x61;
var kWasmH2 = 0x73;
var kWasmH3 = 0x6d;

var kWasmV0 = 0x1;
var kWasmV1 = 0;
var kWasmV2 = 0;
var kWasmV3 = 0;

var kHeaderSize = 8;
var kPageSize = 65536;
var kSpecMaxPages = 65535;

function bytesWithHeader() {
  var buffer = new ArrayBuffer(kHeaderSize + arguments.length);
  var view = new Uint8Array(buffer);
  view[0] = kWasmH0;
  view[1] = kWasmH1;
  view[2] = kWasmH2;
  view[3] = kWasmH3;
  view[4] = kWasmV0;
  view[5] = kWasmV1;
  view[6] = kWasmV2;
  view[7] = kWasmV3;
  for (var i = 0; i < arguments.length; i++) {
    var val = arguments[i];
    if ((typeof val) == "string") val = val.charCodeAt(0);
    view[kHeaderSize + i] = val | 0;
  }
  return buffer;
}

let kDeclNoLocals = 0;

// Section declaration constants
let kUnknownSectionCode = 0;
let kTypeSectionCode = 1;        // Function signature declarations
let kImportSectionCode = 2;      // Import declarations
let kFunctionSectionCode = 3;    // Function declarations
let kTableSectionCode = 4;       // Indirect function table and other tables
let kMemorySectionCode = 5;      // Memory attributes
let kGlobalSectionCode = 6;      // Global declarations
let kExportSectionCode = 7;      // Exports
let kStartSectionCode = 8;       // Start function declaration
let kElementSectionCode = 9;     // Elements section
let kCodeSectionCode = 10;       // Function code
let kDataSectionCode = 11;       // Data segments

// Name section types
let kModuleNameCode = 0;
let kFunctionNamesCode = 1;
let kLocalNamesCode = 2;

let kWasmFunctionTypeForm = 0x60;
let kWasmAnyFunctionTypeForm = 0x70;

let kHasMaximumFlag = 1;
let kResizableMaximumFlag = 1;

// Function declaration flags
let kDeclFunctionName   = 0x01;
let kDeclFunctionImport = 0x02;
let kDeclFunctionLocals = 0x04;
let kDeclFunctionExport = 0x08;

// Local types
let kWasmStmt = 0x40;
let kWasmI32 = 0x7f;
let kWasmI64 = 0x7e;
let kWasmF32 = 0x7d;
let kWasmF64 = 0x7c;
let kWasmS128 = 0x7b;

let kExternalFunction = 0;
let kExternalTable = 1;
let kExternalMemory = 2;
let kExternalGlobal = 3;

let kTableZero = 0;
let kMemoryZero = 0;

// Useful signatures
let kSig_i_i = makeSig([kWasmI32], [kWasmI32]);
let kSig_l_l = makeSig([kWasmI64], [kWasmI64]);
let kSig_i_l = makeSig([kWasmI64], [kWasmI32]);
let kSig_i_ii = makeSig([kWasmI32, kWasmI32], [kWasmI32]);
let kSig_i_iii = makeSig([kWasmI32, kWasmI32, kWasmI32], [kWasmI32]);
let kSig_v_iiii = makeSig([kWasmI32, kWasmI32, kWasmI32, kWasmI32], []);
let kSig_f_ff = makeSig([kWasmF32, kWasmF32], [kWasmF32]);
let kSig_d_dd = makeSig([kWasmF64, kWasmF64], [kWasmF64]);
let kSig_l_ll = makeSig([kWasmI64, kWasmI64], [kWasmI64]);
let kSig_i_dd = makeSig([kWasmF64, kWasmF64], [kWasmI32]);
let kSig_v_v = makeSig([], []);
let kSig_i_v = makeSig([], [kWasmI32]);
let kSig_l_v = makeSig([], [kWasmI64]);
let kSig_f_v = makeSig([], [kWasmF32]);
let kSig_d_v = makeSig([], [kWasmF64]);
let kSig_v_i = makeSig([kWasmI32], []);
let kSig_v_ii = makeSig([kWasmI32, kWasmI32], []);
let kSig_v_iii = makeSig([kWasmI32, kWasmI32, kWasmI32], []);
let kSig_v_l = makeSig([kWasmI64], []);
let kSig_v_d = makeSig([kWasmF64], []);
let kSig_v_dd = makeSig([kWasmF64, kWasmF64], []);
let kSig_v_ddi = makeSig([kWasmF64, kWasmF64, kWasmI32], []);

let kSig_v_f = makeSig([kWasmF32], []);
let kSig_f_f = makeSig([kWasmF32], [kWasmF32]);
let kSig_f_d = makeSig([kWasmF64], [kWasmF32]);
let kSig_d_d = makeSig([kWasmF64], [kWasmF64]);

function makeSig(params, results) {
  return {params: params, results: results};
}

function makeSig_v_x(x) {
  return makeSig([x], []);
}

function makeSig_v_xx(x) {
  return makeSig([x, x], []);
}

function makeSig_r_v(r) {
  return makeSig([], [r]);
}

function makeSig_r_x(r, x) {
  return makeSig([x], [r]);
}

function makeSig_r_xx(r, x) {
  return makeSig([x, x], [r]);
}

// Opcodes
let kExprUnreachable = 0x00;
let kExprNop = 0x01;
let kExprBlock = 0x02;
let kExprLoop = 0x03;
let kExprIf = 0x04;
let kExprElse = 0x05;
let kExprTry = 0x06;
let kExprCatch = 0x07;
let kExprThrow = 0x08;
let kExprEnd = 0x0b;
let kExprBr = 0x0c;
let kExprBrIf = 0x0d;
let kExprBrTable = 0x0e;
let kExprReturn = 0x0f;
let kExprCallFunction = 0x10;
let kExprCallIndirect = 0x11;
let kExprDrop = 0x1a;
let kExprSelect = 0x1b;
let kExprGetLocal = 0x20;
let kExprSetLocal = 0x21;
let kExprTeeLocal = 0x22;
let kExprGetGlobal = 0x23;
let kExprSetGlobal = 0x24;
let kExprI32Const = 0x41;
let kExprI64Const = 0x42;
let kExprF32Const = 0x43;
let kExprF64Const = 0x44;
let kExprI32LoadMem = 0x28;
let kExprI64LoadMem = 0x29;
let kExprF32LoadMem = 0x2a;
let kExprF64LoadMem = 0x2b;
let kExprI32LoadMem8S = 0x2c;
let kExprI32LoadMem8U = 0x2d;
let kExprI32LoadMem16S = 0x2e;
let kExprI32LoadMem16U = 0x2f;
let kExprI64LoadMem8S = 0x30;
let kExprI64LoadMem8U = 0x31;
let kExprI64LoadMem16S = 0x32;
let kExprI64LoadMem16U = 0x33;
let kExprI64LoadMem32S = 0x34;
let kExprI64LoadMem32U = 0x35;
let kExprI32StoreMem = 0x36;
let kExprI64StoreMem = 0x37;
let kExprF32StoreMem = 0x38;
let kExprF64StoreMem = 0x39;
let kExprI32StoreMem8 = 0x3a;
let kExprI32StoreMem16 = 0x3b;
let kExprI64StoreMem8 = 0x3c;
let kExprI64StoreMem16 = 0x3d;
let kExprI64StoreMem32 = 0x3e;
let kExprMemorySize = 0x3f;
let kExprMemoryGrow = 0x40;
let kExprI32Eqz = 0x45;
let kExprI32Eq = 0x46;
let kExprI32Ne = 0x47;
let kExprI32LtS = 0x48;
let kExprI32LtU = 0x49;
let kExprI32GtS = 0x4a;
let kExprI32GtU = 0x4b;
let kExprI32LeS = 0x4c;
let kExprI32LeU = 0x4d;
let kExprI32GeS = 0x4e;
let kExprI32GeU = 0x4f;
let kExprI64Eqz = 0x50;
let kExprI64Eq = 0x51;
let kExprI64Ne = 0x52;
let kExprI64LtS = 0x53;
let kExprI64LtU = 0x54;
let kExprI64GtS = 0x55;
let kExprI64GtU = 0x56;
let kExprI64LeS = 0x57;
let kExprI64LeU = 0x58;
let kExprI64GeS = 0x59;
let kExprI64GeU = 0x5a;
let kExprF32Eq = 0x5b;
let kExprF32Ne = 0x5c;
let kExprF32Lt = 0x5d;
let kExprF32Gt = 0x5e;
let kExprF32Le = 0x5f;
let kExprF32Ge = 0x60;
let kExprF64Eq = 0x61;
let kExprF64Ne = 0x62;
let kExprF64Lt = 0x63;
let kExprF64Gt = 0x64;
let kExprF64Le = 0x65;
let kExprF64Ge = 0x66;
let kExprI32Clz = 0x67;
let kExprI32Ctz = 0x68;
let kExprI32Popcnt = 0x69;
let kExprI32Add = 0x6a;
let kExprI32Sub = 0x6b;
let kExprI32Mul = 0x6c;
let kExprI32DivS = 0x6d;
let kExprI32DivU = 0x6e;
let kExprI32RemS = 0x6f;
let kExprI32RemU = 0x70;
let kExprI32And = 0x71;
let kExprI32Ior = 0x72;
let kExprI32Xor = 0x73;
let kExprI32Shl = 0x74;
let kExprI32ShrS = 0x75;
let kExprI32ShrU = 0x76;
let kExprI32Rol = 0x77;
let kExprI32Ror = 0x78;
let kExprI64Clz = 0x79;
let kExprI64Ctz = 0x7a;
let kExprI64Popcnt = 0x7b;
let kExprI64Add = 0x7c;
let kExprI64Sub = 0x7d;
let kExprI64Mul = 0x7e;
let kExprI64DivS = 0x7f;
let kExprI64DivU = 0x80;
let kExprI64RemS = 0x81;
let kExprI64RemU = 0x82;
let kExprI64And = 0x83;
let kExprI64Ior = 0x84;
let kExprI64Xor = 0x85;
let kExprI64Shl = 0x86;
let kExprI64ShrS = 0x87;
let kExprI64ShrU = 0x88;
let kExprI64Rol = 0x89;
let kExprI64Ror = 0x8a;
let kExprF32Abs = 0x8b;
let kExprF32Neg = 0x8c;
let kExprF32Ceil = 0x8d;
let kExprF32Floor = 0x8e;
let kExprF32Trunc = 0x8f;
let kExprF32NearestInt = 0x90;
let kExprF32Sqrt = 0x91;
let kExprF32Add = 0x92;
let kExprF32Sub = 0x93;
let kExprF32Mul = 0x94;
let kExprF32Div = 0x95;
let kExprF32Min = 0x96;
let kExprF32Max = 0x97;
let kExprF32CopySign = 0x98;
let kExprF64Abs = 0x99;
let kExprF64Neg = 0x9a;
let kExprF64Ceil = 0x9b;
let kExprF64Floor = 0x9c;
let kExprF64Trunc = 0x9d;
let kExprF64NearestInt = 0x9e;
let kExprF64Sqrt = 0x9f;
let kExprF64Add = 0xa0;
let kExprF64Sub = 0xa1;
let kExprF64Mul = 0xa2;
let kExprF64Div = 0xa3;
let kExprF64Min = 0xa4;
let kExprF64Max = 0xa5;
let kExprF64CopySign = 0xa6;
let kExprI32ConvertI64 = 0xa7;
let kExprI32SConvertF32 = 0xa8;
let kExprI32UConvertF32 = 0xa9;
let kExprI32SConvertF64 = 0xaa;
let kExprI32UConvertF64 = 0xab;
let kExprI64SConvertI32 = 0xac;
let kExprI64UConvertI32 = 0xad;
let kExprI64SConvertF32 = 0xae;
let kExprI64UConvertF32 = 0xaf;
let kExprI64SConvertF64 = 0xb0;
let kExprI64UConvertF64 = 0xb1;
let kExprF32SConvertI32 = 0xb2;
let kExprF32UConvertI32 = 0xb3;
let kExprF32SConvertI64 = 0xb4;
let kExprF32UConvertI64 = 0xb5;
let kExprF32ConvertF64 = 0xb6;
let kExprF64SConvertI32 = 0xb7;
let kExprF64UConvertI32 = 0xb8;
let kExprF64SConvertI64 = 0xb9;
let kExprF64UConvertI64 = 0xba;
let kExprF64ConvertF32 = 0xbb;
let kExprI32ReinterpretF32 = 0xbc;
let kExprI64ReinterpretF64 = 0xbd;
let kExprF32ReinterpretI32 = 0xbe;
let kExprF64ReinterpretI64 = 0xbf;

let kTrapUnreachable          = 0;
let kTrapMemOutOfBounds       = 1;
let kTrapDivByZero            = 2;
let kTrapDivUnrepresentable   = 3;
let kTrapRemByZero            = 4;
let kTrapFloatUnrepresentable = 5;
let kTrapFuncInvalid          = 6;
let kTrapFuncSigMismatch      = 7;
let kTrapInvalidIndex         = 8;

let kTrapMsgs = [
  "unreachable",
  "memory access out of bounds",
  "divide by zero",
  "divide result unrepresentable",
  "remainder by zero",
  "integer result unrepresentable",
  "invalid function",
  "function signature mismatch",
  "invalid index into function table"
];

function assertTraps(trap, code) {
  try {
    if (typeof code === 'function') {
      code();
    } else {
      eval(code);
    }
  } catch (e) {
    assertEquals('object', typeof e);
    assertEquals(kTrapMsgs[trap], e.message);
    // Success.
    return;
  }
  throw new MjsUnitAssertionError('Did not trap, expected: ' + kTrapMsgs[trap]);
}

function wasmI32Const(val) {
  let bytes = [kExprI32Const];
  for (let i = 0; i < 4; ++i) {
    bytes.push(0x80 | ((val >> (7 * i)) & 0x7f));
  }
  bytes.push((val >> (7 * 4)) & 0x7f);
  return bytes;
}

function wasmF32Const(f) {
  return [kExprF32Const].concat(Array.from(new Uint8Array((new Float32Array([f])).buffer)));
}

function wasmF64Const(f) {
  return [kExprF64Const].concat(Array.from(new Uint8Array((new Float64Array([f])).buffer)));
}

class Binary extends Array {
  emit_u8(val) {
    this.push(val);
  }

  emit_u16(val) {
    this.push(val & 0xff);
    this.push((val >> 8) & 0xff);
  }

  emit_u32(val) {
    this.push(val & 0xff);
    this.push((val >> 8) & 0xff);
    this.push((val >> 16) & 0xff);
    this.push((val >> 24) & 0xff);
  }

  emit_u32v(val) {
    while (true) {
      let v = val & 0xff;
      val = val >>> 7;
      if (val == 0) {
        this.push(v);
        break;
      }
      this.push(v | 0x80);
    }
  }

  emit_bytes(data) {
    for (let i = 0; i < data.length; i++) {
      this.push(data[i] & 0xff);
    }
  }

  emit_string(string) {
    // When testing illegal names, we pass a byte array directly.
    if (string instanceof Array) {
      this.emit_u32v(string.length);
      this.emit_bytes(string);
      return;
    }

    // This is the hacky way to convert a JavaScript string to a UTF8 encoded
    // string only containing single-byte characters.
    let string_utf8 = unescape(encodeURIComponent(string));
    this.emit_u32v(string_utf8.length);
    for (let i = 0; i < string_utf8.length; i++) {
      this.emit_u8(string_utf8.charCodeAt(i));
    }
  }

  emit_header() {
    this.push(kWasmH0, kWasmH1, kWasmH2, kWasmH3,
              kWasmV0, kWasmV1, kWasmV2, kWasmV3);
  }

  emit_section(section_code, content_generator) {
    // Emit section name.
    this.emit_u8(section_code);
    // Emit the section to a temporary buffer: its full length isn't know yet.
    let section = new Binary;
    content_generator(section);
    // Emit section length.
    this.emit_u32v(section.length);
    // Copy the temporary buffer.
    // Avoid spread because {section} can be huge.
    for (let b of section) this.push(b);
  }
}

class WasmFunctionBuilder {
  constructor(module, name, type_index) {
    this.module = module;
    this.name = name;
    this.type_index = type_index;
    this.body = [];
  }

  exportAs(name) {
    this.module.addExport(name, this.index);
    return this;
  }

  exportFunc() {
    this.exportAs(this.name);
    return this;
  }

  addBody(body) {
    this.body = body;
    return this;
  }

  addLocals(locals) {
    this.locals = locals;
    return this;
  }

  end() {
    return this.module;
  }
}

class WasmGlobalBuilder {
  constructor(module, type, mutable) {
    this.module = module;
    this.type = type;
    this.mutable = mutable;
    this.init = 0;
  }

  exportAs(name) {
    this.module.exports.push({name: name, kind: kExternalGlobal,
                              index: this.index});
    return this;
  }
}

class WasmModuleBuilder {
  constructor() {
    this.types = [];
    this.imports = [];
    this.exports = [];
    this.globals = [];
    this.functions = [];
    this.table_length_min = 0;
    this.table_length_max = undefined;
    this.element_segments = [];
    this.data_segments = [];
    this.segments = [];
    this.explicit = [];
    this.num_imported_funcs = 0;
    this.num_imported_globals = 0;
    return this;
  }

  addStart(start_index) {
    this.start_index = start_index;
    return this;
  }

  addMemory(min, max, exp) {
    this.memory = {min: min, max: max, exp: exp};
    return this;
  }

  addExplicitSection(bytes) {
    this.explicit.push(bytes);
    return this;
  }

  addType(type) {
    // TODO: canonicalize types?
    this.types.push(type);
    return this.types.length - 1;
  }

  addGlobal(local_type, mutable) {
    let glob = new WasmGlobalBuilder(this, local_type, mutable);
    glob.index = this.globals.length + this.num_imported_globals;
    this.globals.push(glob);
    return glob;
  }

  addFunction(name, type) {
    let type_index = (typeof type) == "number" ? type : this.addType(type);
    let func = new WasmFunctionBuilder(this, name, type_index);
    func.index = this.functions.length + this.num_imported_funcs;
    this.functions.push(func);
    return func;
  }

  addImport(module = "", name, type) {
    let type_index = (typeof type) == "number" ? type : this.addType(type);
    this.imports.push({module: module, name: name, kind: kExternalFunction,
                       type: type_index});
    return this.num_imported_funcs++;
  }

  addImportedGlobal(module = "", name, type) {
    let o = {module: module, name: name, kind: kExternalGlobal, type: type,
             mutable: false}
    this.imports.push(o);
    return this.num_imported_globals++;
  }

  addImportedMemory(module = "", name, initial = 0, maximum) {
    let o = {module: module, name: name, kind: kExternalMemory,
             initial: initial, maximum: maximum};
    this.imports.push(o);
    return this;
  }

  addImportedTable(module = "", name, initial, maximum) {
    let o = {module: module, name: name, kind: kExternalTable, initial: initial,
             maximum: maximum};
    this.imports.push(o);
  }

  addExport(name, index) {
    this.exports.push({name: name, kind: kExternalFunction, index: index});
    return this;
  }

  addExportOfKind(name, kind, index) {
    this.exports.push({name: name, kind: kind, index: index});
    return this;
  }

  addDataSegment(addr, data, is_global = false) {
    this.data_segments.push(
        {addr: addr, data: data, is_global: is_global});
    return this.data_segments.length - 1;
  }

  exportMemoryAs(name) {
    this.exports.push({name: name, kind: kExternalMemory, index: 0});
  }

  addElementSegment(base, is_global, array, is_import = false) {
    this.element_segments.push({base: base, is_global: is_global,
                                    array: array});
    if (!is_global) {
      var length = base + array.length;
      if (length > this.table_length_min && !is_import) {
        this.table_length_min = length;
      }
      if (length > this.table_length_max && !is_import) {
         this.table_length_max = length;
      }
    }
    return this;
  }

  appendToTable(array) {
    for (let n of array) {
      if (typeof n != 'number')
        throw new Error('invalid table (entries have to be numbers): ' + array);
    }
    return this.addElementSegment(this.table_length_min, false, array);
  }

  setTableBounds(min, max = undefined) {
    this.table_length_min = min;
    this.table_length_max = max;
    return this;
  }

  // TODO(ssauleau): legacy, remove this
  setFunctionTableLength(length) {
    return this.setTableBounds(length);
  }

  toArray(debug = false) {
    let binary = new Binary;
    let wasm = this;

    // Add header
    binary.emit_header();

    // Add type section
    if (wasm.types.length > 0) {
      if (debug) print("emitting types @ " + binary.length);
      binary.emit_section(kTypeSectionCode, section => {
        section.emit_u32v(wasm.types.length);
        for (let type of wasm.types) {
          section.emit_u8(kWasmFunctionTypeForm);
          section.emit_u32v(type.params.length);
          for (let param of type.params) {
            section.emit_u8(param);
          }
          section.emit_u32v(type.results.length);
          for (let result of type.results) {
            section.emit_u8(result);
          }
        }
      });
    }

    // Add imports section
    if (wasm.imports.length > 0) {
      if (debug) print("emitting imports @ " + binary.length);
      binary.emit_section(kImportSectionCode, section => {
        section.emit_u32v(wasm.imports.length);
        for (let imp of wasm.imports) {
          section.emit_string(imp.module);
          section.emit_string(imp.name || '');
          section.emit_u8(imp.kind);
          if (imp.kind == kExternalFunction) {
            section.emit_u32v(imp.type);
          } else if (imp.kind == kExternalGlobal) {
            section.emit_u32v(imp.type);
            section.emit_u8(imp.mutable);
          } else if (imp.kind == kExternalMemory) {
            var has_max = (typeof imp.maximum) != "undefined";
            section.emit_u8(has_max ? 1 : 0); // flags
            section.emit_u32v(imp.initial); // initial
            if (has_max) section.emit_u32v(imp.maximum); // maximum
          } else if (imp.kind == kExternalTable) {
            section.emit_u8(kWasmAnyFunctionTypeForm);
            var has_max = (typeof imp.maximum) != "undefined";
            section.emit_u8(has_max ? 1 : 0); // flags
            section.emit_u32v(imp.initial); // initial
            if (has_max) section.emit_u32v(imp.maximum); // maximum
          } else {
            throw new Error("unknown/unsupported import kind " + imp.kind);
          }
        }
      });
    }

    // Add functions declarations
    let has_names = false;
    let names = false;
    if (wasm.functions.length > 0) {
      if (debug) print("emitting function decls @ " + binary.length);
      binary.emit_section(kFunctionSectionCode, section => {
        section.emit_u32v(wasm.functions.length);
        for (let func of wasm.functions) {
          has_names = has_names || (func.name != undefined &&
                                   func.name.length > 0);
          section.emit_u32v(func.type_index);
        }
      });
    }

    // Add table section
    if (wasm.table_length_min > 0) {
      if (debug) print("emitting table @ " + binary.length);
      binary.emit_section(kTableSectionCode, section => {
        section.emit_u8(1);  // one table entry
        section.emit_u8(kWasmAnyFunctionTypeForm);
        const max = wasm.table_length_max;
        const has_max = max !== undefined;
        section.emit_u8(has_max ? kHasMaximumFlag : 0);
        section.emit_u32v(wasm.table_length_min);
        if (has_max) section.emit_u32v(max);
      });
    }

    // Add memory section
    if (wasm.memory !== undefined) {
      if (debug) print("emitting memory @ " + binary.length);
      binary.emit_section(kMemorySectionCode, section => {
        section.emit_u8(1);  // one memory entry
        const has_max = wasm.memory.max !== undefined;
        section.emit_u8(has_max ? 1 : 0);
        section.emit_u32v(wasm.memory.min);
        if (has_max) section.emit_u32v(wasm.memory.max);
      });
    }

    // Add global section.
    if (wasm.globals.length > 0) {
      if (debug) print ("emitting globals @ " + binary.length);
      binary.emit_section(kGlobalSectionCode, section => {
        section.emit_u32v(wasm.globals.length);
        for (let global of wasm.globals) {
          section.emit_u8(global.type);
          section.emit_u8(global.mutable);
          if ((typeof global.init_index) == "undefined") {
            // Emit a constant initializer.
            switch (global.type) {
            case kWasmI32:
              section.emit_u8(kExprI32Const);
              section.emit_u32v(global.init);
              break;
            case kWasmI64:
              section.emit_u8(kExprI64Const);
              section.emit_u8(global.init);
              break;
            case kWasmF32:
              section.emit_u8(kExprF32Const);
              f32_view[0] = global.init;
              section.emit_u8(byte_view[0]);
              section.emit_u8(byte_view[1]);
              section.emit_u8(byte_view[2]);
              section.emit_u8(byte_view[3]);
              break;
            case kWasmF64:
              section.emit_u8(kExprF64Const);
              f64_view[0] = global.init;
              section.emit_u8(byte_view[0]);
              section.emit_u8(byte_view[1]);
              section.emit_u8(byte_view[2]);
              section.emit_u8(byte_view[3]);
              section.emit_u8(byte_view[4]);
              section.emit_u8(byte_view[5]);
              section.emit_u8(byte_view[6]);
              section.emit_u8(byte_view[7]);
              break;
            }
          } else {
            // Emit a global-index initializer.
            section.emit_u8(kExprGetGlobal);
            section.emit_u32v(global.init_index);
          }
          section.emit_u8(kExprEnd);  // end of init expression
        }
      });
    }

    // Add export table.
    var mem_export = (wasm.memory !== undefined && wasm.memory.exp);
    var exports_count = wasm.exports.length + (mem_export ? 1 : 0);
    if (exports_count > 0) {
      if (debug) print("emitting exports @ " + binary.length);
      binary.emit_section(kExportSectionCode, section => {
        section.emit_u32v(exports_count);
        for (let exp of wasm.exports) {
          section.emit_string(exp.name);
          section.emit_u8(exp.kind);
          section.emit_u32v(exp.index);
        }
        if (mem_export) {
          section.emit_string("memory");
          section.emit_u8(kExternalMemory);
          section.emit_u8(0);
        }
      });
    }

    // Add start function section.
    if (wasm.start_index != undefined) {
      if (debug) print("emitting start function @ " + binary.length);
      binary.emit_section(kStartSectionCode, section => {
        section.emit_u32v(wasm.start_index);
      });
    }

    // Add element segments
    if (wasm.element_segments.length > 0) {
      if (debug) print("emitting element segments @ " + binary.length);
      binary.emit_section(kElementSectionCode, section => {
        var inits = wasm.element_segments;
        section.emit_u32v(inits.length);

        for (let init of inits) {
          section.emit_u8(0);  // table index / flags
          if (init.is_global) {
            section.emit_u8(kExprGetGlobal);
          } else {
            section.emit_u8(kExprI32Const);
          }
          section.emit_u32v(init.base);
          section.emit_u8(kExprEnd);
          section.emit_u32v(init.array.length);
          for (let index of init.array) {
            section.emit_u32v(index);
          }
        }
      });
    }

    // Add function bodies.
    if (wasm.functions.length > 0) {
      // emit function bodies
      if (debug) print("emitting code @ " + binary.length);
      binary.emit_section(kCodeSectionCode, section => {
        section.emit_u32v(wasm.functions.length);
        for (let func of wasm.functions) {
          // Function body length will be patched later.
          let local_decls = [];
          let l = func.locals;
          if (l != undefined) {
            let local_decls_count = 0;
            if (l.i32_count > 0) {
              local_decls.push({count: l.i32_count, type: kWasmI32});
            }
            if (l.i64_count > 0) {
              local_decls.push({count: l.i64_count, type: kWasmI64});
            }
            if (l.f32_count > 0) {
              local_decls.push({count: l.f32_count, type: kWasmF32});
            }
            if (l.f64_count > 0) {
              local_decls.push({count: l.f64_count, type: kWasmF64});
            }
          }

          let header = new Binary;
          header.emit_u32v(local_decls.length);
          for (let decl of local_decls) {
            header.emit_u32v(decl.count);
            header.emit_u8(decl.type);
          }

          section.emit_u32v(header.length + func.body.length);
          section.emit_bytes(header);
          section.emit_bytes(func.body);
        }
      });
    }

    // Add data segments.
    if (wasm.data_segments.length > 0) {
      if (debug) print("emitting data segments @ " + binary.length);
      binary.emit_section(kDataSectionCode, section => {
        section.emit_u32v(wasm.data_segments.length);
        for (let seg of wasm.data_segments) {
          section.emit_u8(0);  // linear memory index 0 / flags
          if (seg.is_global) {
            // initializer is a global variable
            section.emit_u8(kExprGetGlobal);
            section.emit_u32v(seg.addr);
          } else {
            // initializer is a constant
            section.emit_u8(kExprI32Const);
            section.emit_u32v(seg.addr);
          }
          section.emit_u8(kExprEnd);
          section.emit_u32v(seg.data.length);
          section.emit_bytes(seg.data);
        }
      });
    }

    // Add any explicitly added sections
    for (let exp of wasm.explicit) {
      if (debug) print("emitting explicit @ " + binary.length);
      binary.emit_bytes(exp);
    }

    // Add function names.
    if (has_names) {
      if (debug) print("emitting names @ " + binary.length);
      binary.emit_section(kUnknownSectionCode, section => {
        section.emit_string("name");
        var count = wasm.functions.length + wasm.num_imported_funcs;
        section.emit_u32v(count);
        for (var i = 0; i < wasm.num_imported_funcs; i++) {
          section.emit_u8(0); // empty string
          section.emit_u8(0); // local names count == 0
        }
        for (let func of wasm.functions) {
          var name = func.name == undefined ? "" : func.name;
          section.emit_string(name);
          section.emit_u8(0);  // local names count == 0
        }
      });
    }

    return binary;
  }

  toBuffer(debug = false) {
    let bytes = this.toArray(debug);
    let buffer = new ArrayBuffer(bytes.length);
    let view = new Uint8Array(buffer);
    for (let i = 0; i < bytes.length; i++) {
      let val = bytes[i];
      if ((typeof val) == "string") val = val.charCodeAt(0);
      view[i] = val | 0;
    }
    return new Uint8Array(buffer);
  }

  instantiate(...args) {
    let module = new WebAssembly.Module(this.toBuffer());
    let instance = new WebAssembly.Instance(module, ...args);
    return instance;
  }
}
