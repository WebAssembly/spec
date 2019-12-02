#!/usr/bin/env python3

"""
This file is used for generating simd_f64x2_cmp.wast file.
Which inherites from `SimdArithmeticCase` class, overloads
the `get_test_cases` method, and reset the Test Case template.
The reason why this is different from other cmp files is that
f64x2 only has 6 comparison instructions but with amounts of
test datas.
"""

from simd_arithmetic import SimdArithmeticCase
from simd_float_op import FloatingPointCmpOp


class Simdf64x2CmpCase(SimdArithmeticCase):
    LANE_LEN = 4
    LANE_TYPE = 'f64x2'

    UNARY_OPS = ()
    BINARY_OPS = ('eq', 'ne', 'lt', 'le', 'gt', 'ge',)
    floatOp = FloatingPointCmpOp()

    FLOAT_NUMBERS_SPECIAL = ('0x1p-1074', '-inf', '0x1.921fb54442d18p+2',
                             '0x1p+0', '-0x1.fffffffffffffp+1023', '-0x0p+0', '-0x1p-1', '0x1.fffffffffffffp+1023',
                             '-0x1p-1074', '-0x1p-1022', '0x1p-1', '-0x1.921fb54442d18p+2',
                             '0x0p+0', 'inf', '-0x1p+0', '0x1p-1022'
                            )

    FLOAT_NUMBERS_NORMAL = ('-1', '0', '1', '2.0')

    NAN_NUMBERS = ('nan', '-nan', 'nan:0x4000000000000', '-nan:0x4000000000000')

    binary_params_template = ('({} (invoke "{}" ', '{}', '{})', '{})')
    unary_param_template = ('({} (invoke "{}" ', '{})', '{})')
    binary_nan_template = ('({} (invoke "{}" ', '{}', '{}))')
    unary_nan_template = ('({} (invoke "{}" ', '{}))')

    def full_op_name(self, op_name):
        return self.LANE_TYPE + '.' + op_name

    @staticmethod
    def v128_const(lane, val):
        lane_cnt = 2 if lane in ['f64x2', 'i64x2'] else 4
        return '(v128.const {} {})'.format(lane, ' '.join([str(val)] * lane_cnt))

    @property
    def combine_ternary_arith_test_data(self):
        return {}

    @property
    def combine_binary_arith_test_data(self):
        return ['f64x2.eq', 'f64x2.ne', 'f64x2.lt', 'f64x2.le', 'f64x2.gt', 'f64x2.ge']

    def single_binary_test(self, case):
        """Format a test case in 2 or 3 lines

        :param case: list of elements about the test case
        :return: test cases with 2 v128.const f64x2 operands, 3 lines at most
        """
        op_name = case[1]
        arg1 = self.v128_const(self.LANE_TYPE, case[2])
        arg2 = self.v128_const(self.LANE_TYPE, case[3])

        if len(case) == 4:
            line_head = self.binary_nan_template[0].format(case[0], op_name)
            line_head_len = len(line_head)
            blank_head = ' ' * line_head_len
            lines = [
                line_head + self.binary_nan_template[1].format(arg1),
                blank_head + self.binary_nan_template[2].format(arg2)
            ]
        elif len(case) == 5:
            line_head = self.binary_params_template[0].format(case[0], op_name)
            line_head_len = len(line_head)
            blank_head = ' ' * line_head_len
            result = self.v128_const('i64x2', case[-1])
            lines = [
                line_head + self.binary_params_template[1].format(arg1),
                blank_head + self.binary_params_template[2].format(arg2),
                blank_head + self.binary_params_template[3].format(result)
            ]
        else:
            raise Exception('Invalid format for the test case!')

        return '\n'.join(lines)

    def single_unary_test(self, case):
        """Format a test case in 1 line or 2 lines

        :param case: list of elements about the test case
        :return: test cases with 2 v128.const f64x2 operands, 2 lines at most
        """
        op_name = case[1]
        arg = self.v128_const(self.LANE_TYPE, case[2])

        if len(case) == 3:
            line_head = self.unary_nan_template[0].format(case[0], op_name)
            lines = [
                line_head + self.unary_nan_template[1].format(arg)
            ]
        elif len(case) == 4:
            line_head = self.unary_param_template[0].format(case[0], op_name)
            line_head_len = len(line_head)
            blank_head = ' ' * line_head_len
            result = self.v128_const(self.LANE_TYPE, case[-1])
            lines = [
                line_head + self.unary_param_template[1].format(arg),
                blank_head + self.unary_param_template[2].format(result)
            ]
        else:
            raise Exception('Invalid format for the test case!')

        return '\n'.join(lines)

    def get_combine_cases(self):
        combine_cases = [';; combination\n(module (memory 1)']

        # append funcs
        binary_fn_template = '  (func (export "{}-in-block")\n' \
                             '    (block\n' \
                             '      (drop\n' \
                             '        (block (result v128)\n' \
                             '          ({}\n' \
                             '            (block (result v128) (v128.load (i32.const 0)))\n' \
                             '            (block (result v128) (v128.load (i32.const 1)))\n' \
                             '          )\n' \
                             '        )\n' \
                             '      )\n' \
                             '    )\n' \
                             '  )'
        for fn_name in self.combine_binary_arith_test_data:
            combine_cases.append(binary_fn_template.format(fn_name, fn_name))

        binary_fn_template = '  (func (export "nested-{fn}")\n' \
                             '    (drop\n' \
                             '      ({fn}\n' \
                             '        ({fn}\n' \
                             '          ({fn}\n' \
                             '            (v128.load (i32.const 0))\n' \
                             '            (v128.load (i32.const 1))\n' \
                             '          )\n' \
                             '          ({fn}\n' \
                             '            (v128.load (i32.const 2))\n' \
                             '            (v128.load (i32.const 3))\n' \
                             '          )\n' \
                             '        )\n' \
                             '        ({fn}\n' \
                             '          ({fn}\n' \
                             '            (v128.load (i32.const 0))\n' \
                             '            (v128.load (i32.const 1))\n' \
                             '          )\n' \
                             '          ({fn}\n' \
                             '            (v128.load (i32.const 2))\n' \
                             '            (v128.load (i32.const 3))\n' \
                             '          )\n' \
                             '        )\n' \
                             '      )\n' \
                             '    )\n' \
                             '  )' \

        for fn_name in self.combine_binary_arith_test_data:
            combine_cases.append(binary_fn_template.format(fn=fn_name))

        combine_cases.append('  (func (export "as-param")\n'
                             '    (drop\n'
                             '      (f64x2.eq\n'
                             '        (f64x2.ne\n'
                             '          (f64x2.lt\n'
                             '            (v128.load (i32.const 0))\n'
                             '            (v128.load (i32.const 1))\n'
                             '          )\n'
                             '          (f64x2.le\n'
                             '            (v128.load (i32.const 2))\n'
                             '            (v128.load (i32.const 3))\n'
                             '          )\n'
                             '        )\n'
                             '        (f64x2.gt\n'
                             '          (f64x2.ge\n'
                             '            (v128.load (i32.const 0))\n'
                             '            (v128.load (i32.const 1))\n'
                             '          )\n'
                             '          (f64x2.eq\n'
                             '            (v128.load (i32.const 2))\n'
                             '            (v128.load (i32.const 3))\n'
                             '          )\n'
                             '        )\n'
                             '      )\n'
                             '    )\n'
                             '  )')

        combine_cases.append(')')

        # append assert
        binary_case_template = ('(assert_return (invoke "{fn}-in-block"))')
        for fn_name in self.combine_binary_arith_test_data:
            combine_cases.append(binary_case_template.format(fn=fn_name))

        binary_case_template = ('(assert_return (invoke "nested-{fn}"))')
        for fn_name in self.combine_binary_arith_test_data:
            combine_cases.append(binary_case_template.format(fn=fn_name))

        combine_cases.append('(assert_return (invoke "as-param"))\n')

        return '\n'.join(combine_cases)

    def get_normal_case(self):
        """Normal test cases from WebAssembly core tests
        """
        cases = []
        binary_test_data = []
        unary_test_data = []

        for op in self.BINARY_OPS:
            op_name = self.full_op_name(op)
            for p1 in self.FLOAT_NUMBERS_SPECIAL:
                for p2 in self.FLOAT_NUMBERS_SPECIAL + self.NAN_NUMBERS:
                    result = self.floatOp.binary_op(op, p1, p2)
                    binary_test_data.append(['assert_return', op_name, p1, p2, result])

            for p1 in self.NAN_NUMBERS:
                for p2 in self.FLOAT_NUMBERS_SPECIAL + self.NAN_NUMBERS:
                    result = self.floatOp.binary_op(op, p1, p2)
                    binary_test_data.append(['assert_return', op_name, p1, p2, result])

        for op in self.BINARY_OPS:
            op_name = self.full_op_name(op)
            for p1 in self.FLOAT_NUMBERS_NORMAL:
                for p2 in self.FLOAT_NUMBERS_NORMAL:
                    result = self.floatOp.binary_op(op, p1, p2)
                    binary_test_data.append(['assert_return', op_name, p1, p2, result])

        for case in binary_test_data:
            cases.append(self.single_binary_test(case))

        for case in unary_test_data:
            cases.append(self.single_unary_test(case))

        self.get_unknown_operator_case(cases)

        return '\n'.join(cases)

    def get_unknown_operator_case(self, cases):
        """Unknown operator cases.
        """

        tpl_assert = "(assert_malformed (module quote \"(memory 1) (func " \
                     " (param $x v128) (param $y v128) (result v128) " \
                     "({}.{} (local.get $x) (local.get $y)))\") \"unknown operator\")"

        cases.append('\n\n;; unknown operators')

        for lane_type in ['f2x64']:
            for op in self.BINARY_OPS:
                cases.append(tpl_assert.format(lane_type,
                                               op,
                                               ' '.join([self.v128_const('i32x4', '0')]*2)))

    def gen_test_cases(self):
        wast_filename = '../simd_{lane_type}_cmp.wast'.format(lane_type=self.LANE_TYPE)
        with open(wast_filename, 'w') as fp:
            txt_test_case = self.get_all_cases()
            txt_test_case = txt_test_case.replace('f64x2 arithmetic', 'f64x2 comparison')
            fp.write(txt_test_case)


def gen_test_cases():
    simd_f64x2_cmp = Simdf64x2CmpCase()
    simd_f64x2_cmp.gen_test_cases()


if __name__ == '__main__':
    gen_test_cases()