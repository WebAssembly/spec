
// Building the stack

// we should only need the critical path
var path = JSON.parse(fs.readFileSync("critical.out"))

var code = fs.readFileSync("test.wasm")

var step = 0

var fstack = []

function startCritical(loc) {
    // check if we are on the critical path
    if (path.length == 0) return false
    step++
    var el = path[0]
    if (el.loc == loc) {
        console.log("found path", el.loc)
        path = path.slice(1)
        return true
    }
    return false
}

function bytes(n) {
    var res = ""
    for (var i = 0; i < 4; i++) {
        res = String.fromCharCode(n & 0xff) + res
        n = n / 256
    }
    return res
}

function pow2(x) { return Math.pow(2, x) }

function depth(x) {
    if (x <= 1) return 0
    else return 1 + depth(x/2)
}

function makeMerkle(arr, idx, level) {
    if (level == 0) return idx < arr.length ? bytes(arr[idx]) : "";
    else return keccak256(makeMerkle(arr, idx, level-1), makeMerkle(arr, idx+Math.pow(2,level-1), level-1));
}

function getHash(arr) {
    return makeMerkle(arr, 0, depth(arr.length*2-1))
}

// making merkle proofs
function getLocationProof(arr,idx,loc,level) {
  if (level == 1) return [bytes (arr[idx+1]), bytes(arr[idx])]
  let sz = Math.pow(2, level-1)
  if (idx + sz > loc) return [makeMerkle(arr, idx+pow2(level-1), level-1)].concat(getLocationProof(arr,idx,loc,level-1))
  else return [makeMerkle(arr,idx,level-1)].concat(getLocationProof(arr,idx+pow2(level-1), loc, level-1))
}

function locationProof(arr,loc) {
    return getLocationProof(arr, 0, loc, depth(arr.length*2-1))
}

var proofs = []

function popStack(vm) {
    var res = vm.stack[vm.stack_ptr]
    proofs.push(locationProof(vm.stack, vm.stack_ptr))
    vm.stack[vm.stack_ptr] = 0
    vm.stack_ptr--
    return res
}

function pushStack(vm, v) {
    proofs.push([locationProof(vm.stack, vm.stack_ptr), v])
    vm.stack_ptr++
    vm.stack[vm.stack_ptr] = v
}

function readInst(vm) {
    var res = vm.code[vm.pc]
    proofs.push(locationProof(vm.code, vm.pc))
    return res
}

function handleAddition(vm) {
    readInst(vm)
    var a1 = popStack(vm)
    var a2 = popStack(vm)
    pushStack(a1+a2)
}

function hashVM(vm) {
    return keccak256(bytes(vm.stack_ptr), bytes(vm.pc), bytes(vm.fstack_ptr), getHash(vm.locals), getHash(vm.stack), getHash(vm.code), getHash(vm.fstack))
}

function vmProof(vm) {
    return {
        stack: getHash(vm.stack),
        fstack: getHash(vm.fstack),
        code: getHash(vm.code),
        locals: getHash(vm.locals),
        pc: vm.pc,
        stack_ptr: vm.stack_ptr,
        fstack_ptr: vm.fsatck_ptr,
    }
}

function buildVM(loc) {
    return {
        stack: stack,
        fstack: fstack,
        pc: loc,
        code: code,
        locals: locals,
        stack_ptr: stack.length-1,
        fstack_ptr: fstack.length-1,
    }
}

var stack = []

Module.asmLibraryArg.adjustStack0 = function (num) {
    console.log("adjust", num)
    stack.length -= num
}

Module.asmLibraryArg.countBottom = function (loc) {
    if (path.length == 0) console.log("*** bottom level", loc)
    console.log("Instruction", code[loc])
    if (code[loc] == 0x02) console.log("Stack type", code[loc+1])
    // stack.length -= num
}

Module.asmLibraryArg.adjustStackI32 = function (v, num) {
    stack.length -= num
    stack.push(v)
    console.log("adjust i32", v, num, "stack len", stack.length)
    return v
}

var locals = []
var local_index = 0

Module.asmLibraryArg.storeLocalI32 = function (num, v) {
    locals[num+local_index] = v
    console.log("store i32", v, num)
}

Module.asmLibraryArg.numLocals = function (num) {
    local_index = locals.length
    locals.length += num
    console.log("locals:", num)
}

Module.asmLibraryArg.storeLocalF32 = function (num, v) {
    locals[num] = v
    console.log("store f32", v, num)
}

Module.asmLibraryArg.storeLocalF64 = function (num, v) {
    locals[num] = v
    console.log("store f64", v, num)
}

function getI64() {
    var buffer = new ArrayBuffer(8)
    var view = new Uint8Array(buffer)
    for (var i = 0; i < 8; i++) {
        view[i] = HEAP8[64+i]
    }
    return view
}

function i64str(view) {
    var str = ""
    for (var i = 0; i < 8; i++) {
        str = str + (Math.floor(view[i]/16)).toString(16) + (view[i]%16).toString(16)
    }
    return str
}

Module.asmLibraryArg.storeLocalI64 = function (num) {
    var v = getI64()
    locals[num] = v
    console.log("store i64", i64str(v), num)
}

Module.asmLibraryArg.adjustStackF32 = function (v, num) {
    stack.length -= num
    stack.push(v)
    console.log("adjust f32", v, num, "stack len", stack.length)
    return v
}

Module.asmLibraryArg.adjustStackI64 = function (num) {
    stack.length -= num
    var v = getI64()
    stack.push(v)
    console.log("adjust i64", i64str(v), num, "stack len", stack.length)
    return 0
}
/*
Module.asmLibraryArg.adjustStackI64 = function (v, num) {
    // stack.length -= num
    stack.push(v)
    console.log("adjust i64", v, num)
    return v
}
*/

Module.asmLibraryArg.adjustStackF64 = function (v, num) {
    stack.length -= num
    stack.push(v)
    console.log("adjust f64", v, num)
    return v
}

Module.asmLibraryArg.pushCritical = function (loc) {
    if (path.length == 0) return false
    console.log("at function", loc)
    fstack.push(loc)
    return startCritical(loc)
}

Module.asmLibraryArg.popCritical = function () {
    if (fstack.length > 0) fstack.length--
    // console.log("exiting function")
    step++
}

Module.asmLibraryArg.endCritical = function () {
    step++
}

Module.asmLibraryArg.startCritical = startCritical

