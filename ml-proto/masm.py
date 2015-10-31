#!/usr/bin/env python

import sexp
import itertools

class LowerWhileLoop(sexp.IdentityTransform):
    """High-level-style top-test "while" loop expansion."""

    def transform_list_postorder(self, x):
        if not x.is_operator('while'):
            return x
        if x.num_operands() != 2:
            raise "a while loop should have exactly 2 operands"

        condition = x.get_operand(0)
        body = x.get_operand(1)

        # While the code may look scary at first, consider:
        # Top-test while loops are suboptimal, so what's really happening here
        # is that the macro is optimizing the loop for you. Second, it'll be
        # shorter once we get br_if. And third, there's probably a way to write
        # a python API to make the actual python code here shorter. I'm fairly
        # inexperienced in python and would welcome suggestions on how best to
        # do that.
        s = sexp.SExp
        return s([s('if'),
                  condition,
                  s([s('loop'), s('$exit'),
                     body,
                     s([s('if'),
                        s([s('i32.eq'),
                           condition,
                           s([s('i32.const'), s(0)]),
                          ]),
                        s([s('break'), s('$exit')])
                       ])
                    ])
                 ])
                 
class DefineApply(sexp.IdentityTransform):
    """Simple define element"""
    
    def transform_list_preorder(self, x):
        defineList = []
        retSexp = []
        for operand in x.thing:
            if operand.is_operator('define'):
                if operand.num_operands() != 2:
                    raise "a define instruction needs 2 operands"
                #this line is an awful hack
                #it seems, that if I don't add the (define ...) operand, it gets treated like a comment
                #and ends up in the generated code, which it obviously never should
                #therefore this line overwrites the original (define ...) with an actual comment
                retSexp.append(sexp.SExp(';; here was a define', operand.begin, operand.end))
                operand.get_operand(1).strip()
                defineList.append([operand.get_operand(0).thing, operand.get_operand(1).thing])
            else:
                for item in defineList:
                    operand = replaceOperand(operand, item[0], item[1])
                retSexp.append(operand)
        return sexp.SExp(retSexp, x.begin, x.end)
        
                 
class ForEachApply(sexp.IdentityTransform):
    """Foreach macro expansion"""

    def transform_list_postorder(self, x):
        if not x.is_operator('foreach'):
            return x
        if x.num_operands() < 3:
            raise "a foreach instruction needs 3 operands"
        
        symbol = x.get_operand(0)
        apply = x.get_operand(1)
        
        if not isinstance(apply.thing, list) or not apply.is_operator('apply'):
            raise "the apply-operand needs to look like this: (apply 42 0xCAFE 3.141 \"wasm4life\")"
        
        retSexp = []
        iterCode = iter(x.thing)
        
        for code in itertools.islice(iterCode, 3, None):
            code.strip()
            iterApply = iter(apply.thing)
            next(iterApply)
            for subs in iterApply:
                retSexp.append(replaceSymbol(code, symbol.thing, subs.thing))
            
        return sexp.SExp(retSexp, x.begin, x.end)
            
        
            
class RepairMultiBracket(sexp.IdentityTransform):
    """Repairs some non-harmful extra brackets"""
    
    def transform_list_preorder(self, x):
        retSexp = []
        for operand in x.thing:
            if isinstance(operand.thing, list) and len(operand.thing) > 0 and isinstance(operand.thing[0].thing, list):
                retSexp.extend(operand.thing)
            else:
                retSexp.append(operand)
        return sexp.SExp(retSexp, x.begin, x.end)
    
def replaceSymbol(b, sym, _subs):
    subs = str(_subs)
    if isinstance(b.thing, list):
        nested = []
        for item in b.thing:
            nested.append(replaceSymbol(item, sym, subs))
        return sexp.SExp(nested, b.begin, b.end)
    else:
        item = b.thing
        if isinstance(item, str):
            item = item.replace(sym, subs)
        return sexp.SExp(item, b.begin, b.end)  

def replaceOperand(b, sym, operand):
    if isinstance(b.thing, list):
        nested = []
        for item in b.thing:
            nested.append(replaceOperand(item, sym, operand))
        return sexp.SExp(nested, b.begin, b.end)
    else:
        item = b.thing
        if item == sym:
            item=operand
        return sexp.SExp(item, b.begin, b.end)

def transform_expr(fromExpr):
    toExpr = sexp.transform(fromExpr, LowerWhileLoop())
    toExpr = sexp.transform(toExpr, DefineApply())
    toExpr = sexp.transform(toExpr, ForEachApply())
    toExpr = sexp.transform(toExpr, RepairMultiBracket())
    return toExpr

def transform_string(fromStr):
    fromExpr = sexp.parse_toplevel(fromStr)
    toExpr = transform_expr(fromExpr)
    toStr = sexp.toplevel_to_string_with_template(toExpr, fromStr)
    return toStr

def transform_file(fromPath, toPath):
    fromFile = open(fromPath, 'r')
    fromStr = fromFile.read()
    fromFile.close()
    toStr = transform_string(fromStr)
    toFile = open(toPath, 'w')
    toFile.write(';; Generated by masm.py from ' + fromPath + '\n')
    toFile.write(toStr)
    toFile.close()
