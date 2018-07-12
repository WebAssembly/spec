
// const fs = require("fs")

var stack = []
var step = 0
var target = 10000

function checkFinish() {
    if (target == step) {
        console.log(stack)
        fs.writeFileSync("critical.out", JSON.stringify(stack))
    }
}

function pushCritical(loc) {
    if (step > target) return
    stack.push({step: step, loc:loc})
    checkFinish()
    step++
}

function pushCallCritical(loc, func) {
    if (step > target) return
    stack.push({step: step, loc:loc, func:func})
    checkFinish()
    step++
}

function pushFuncCritical(loc) {
    if (step > target) return
    console.log("at function", loc)
    stack.push({step: step, loc:loc, func:true})
    checkFinish()
    step++
}

function pushIndirectCritical(func, loc) {
    if (step > target) return func
    stack.push({step: step, loc:loc, func:func})
    checkFinish()
    step++
    // console.log("push indirect", func, loc)
    return func
}

function popCritical() {
    if (step > target || stack.length == 0) return
    var last = stack[stack.length-1]
    if (!last.func) return
    checkFinish()
    stack.pop()
    step++
}

function popLoopCritical(loc) {
    if (step > target || stack.length == 0) return
    var last = stack[stack.length-1]
    if (last.loc != loc) return
    checkFinish()
    // if (Math.random() < 0.0001) console.log(stack, step)
    stack.pop()
    step++
}

function startBlock(loc) {
    if (step > target) return
    // console.log("Start " + loc)
    stack.push({step: step, loc:loc})
    checkFinish()
    step++
    // console.log(stack)
}

function endBlock(loc) {
    if (step > target) return
    // console.log("End " + loc)
    if (stack.length == 0) {
        console.log("Trying to pop from empty stack!")
        return
    }
    checkFinish()
    var last = stack[stack.length-1]
    stack.length--
    while (stack.length != 0 && last.loc != loc) {
        last = stack[stack.length-1]
        stack.length--
    }
    step++
}

Module.asmLibraryArg.pushCritical = pushCritical
Module.asmLibraryArg.pushFuncCritical = pushFuncCritical
Module.asmLibraryArg.pushCallCritical = pushCallCritical
Module.asmLibraryArg.pushIndirectCritical = pushIndirectCritical
Module.asmLibraryArg.popCritical = popCritical
Module.asmLibraryArg.popLoopCritical = popLoopCritical

Module.asmLibraryArg.startCritical = startBlock
Module.asmLibraryArg.endCritical = endBlock

