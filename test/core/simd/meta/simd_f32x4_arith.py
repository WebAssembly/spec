#!/usr/bin/env python3

"""
Generate f32x4 floating-point arithmetic operation cases.
"""

import math
from simd_arithmetic import SimdArithmeticCase


def binary_op(op: str, p1: str, p2: str) -> str:
    """Binary operation on p1 and p2 with the operation specified by op

    :param op: add, sub, mul,
    :param p1: float number in hex
    :param p2: float number in hex
    :return:
    """
    f1 = float.fromhex(p1)
    f2 = float.fromhex(p2)
    if op == 'add':
        if 'inf' in p1 and 'inf' in p2 and p1 != p2:
            return '-nan'
        result = f1 + f2

    elif op == 'sub':
        if 'inf' in p1 and 'inf' in p2 and p1 == p2:
            return '-nan'
        result = f1 - f2

    elif op == 'mul':
        if '0x0p+0' in p1 and 'inf' in p2 or 'inf' in p1 and '0x0p+0' in p2:
            return '-nan'
        result = f1 * f2

    elif op == 'div':
        if '0x0p+0' in p1 and '0x0p+0' in p2:
            return '-nan'
        if 'inf' in p1 and 'inf' in p2:
            return '-nan'

        try:
            result = f1 / f2
            return get_valid_float(result)
        except ZeroDivisionError:
            if p1[0] == p2[0]:
                return 'inf'
            elif p1 == 'inf' and p2 == '0x0p+0':
                return 'inf'
            else:
                return '-inf'

    else:
        raise Exception('Unknown binary operation')

    return get_valid_float(result)


def get_valid_float(value):
    if value > float.fromhex('0x1.fffffep+127'):
        return 'inf'
    if value < float.fromhex('-0x1.fffffep+127'):
        return '-inf'
    return value.hex()


def float_sqrt(p):
    if p == '-0x0p+0':
        return '-0x0p+0'

    try:
        p = float.fromhex(p)
        result = float.hex(math.sqrt(p))
    except ValueError:
        result = '-nan'

    return result


def float_neg(p):
    if p == 'nan':
        return '-nan'
    try:
        p = float.fromhex(p)
        result = float.hex(-p)
    except ValueError:
        if p.startswith('nan:'):
            return '-' + p
        if p.startswith('-nan:'):
            return p[1:]

    return result


class Simdf32x4ArithmeticCase(SimdArithmeticCase):
    LANE_LEN = 4
    LANE_TYPE = 'f32x4'

    UNARY_OPS = ('neg', 'sqrt')
    BINARY_OPS = ('add', 'sub', 'mul', 'div',)

    FLOAT_NUMBERS = (
        '0x0p+0', '-0x0p+0', '0x1p-149', '-0x1p-149', '0x1p-126', '-0x1p-126', '0x1p-1', '-0x1p-1', '0x1p+0', '-0x1p+0',
        '0x1.921fb6p+2', '-0x1.921fb6p+2', '0x1.fffffep+127', '-0x1.fffffep+127', 'inf', '-inf'
    )

    NAN_NUMBERS = ('nan', '-nan', 'nan:0x200000', '-nan:0x200000')
    binary_params_template = ('({} (invoke "{}" ', '{}', '{})', '{})')
    unary_param_template = ('({} (invoke "{}" ', '{})', '{})')
    binary_nan_template = ('({} (invoke "{}" ', '{}', '{}))')
    unary_nan_template = ('({} (invoke "{}" ', '{}))')

    def full_op_name(self, op_name):
        return self.LANE_TYPE + '.' + op_name

    @staticmethod
    def v128_const(lane, val):
        return '(v128.const {} {})'.format(lane, ' '.join([str(val)] * 4))

    @property
    def combine_ternary_arith_test_data(self):
        return {
            'add-sub': [
                ['1.125'] * 4, ['0.25'] * 4, ['0.125'] * 4, ['1.0'] * 4
            ],
            'sub-add': [
                ['1.125'] * 4, ['0.25'] * 4, ['0.125'] * 4, ['1.25'] * 4
            ],
            'mul-add': [
                ['1.25'] * 4, ['0.25'] * 4, ['0.25'] * 4, ['0.375'] * 4
            ],
            'mul-sub': [
                ['1.125'] * 4, ['0.125'] * 4, ['0.25'] * 4, ['0.25'] * 4
            ],
            'div-add': [
                ['1.125'] * 4, ['0.125'] * 4, ['0.25'] * 4, ['5.0'] * 4
            ],
            'div-sub': [
                ['1.125'] * 4, ['0.125'] * 4, ['0.25'] * 4, ['4.0'] * 4
            ],
            'mul-div': [
                ['1.125'] * 4, ['0.125'] * 4, ['0.25'] * 4, ['2.25'] * 4
            ],
            'div-mul': [
                ['1.125'] * 4, ['4'] * 4, ['0.25'] * 4, ['18.0'] * 4
            ]
        }

    @property
    def combine_binary_arith_test_data(self):
        return {
            'add-neg': [
                ['1.125'] * 4, ['0.125'] * 4, ['-1.0'] * 4
            ],
            'sub-neg': [
                ['1.125'] * 4, ['0.125'] * 4, ['-1.25'] * 4
            ],
            'mul-neg': [
                ['1.5'] * 4, ['0.25'] * 4, ['-0.375'] * 4
            ],
            'div-neg': [
                ['1.5'] * 4, ['0.25'] * 4, ['-6'] * 4
            ],
            'add-sqrt': [
                ['2.25'] * 4, ['0.25'] * 4, ['1.75'] * 4
            ],
            'sub-sqrt': [
                ['2.25'] * 4, ['0.25'] * 4, ['1.25'] * 4
            ],
            'mul-sqrt': [
                ['2.25'] * 4, ['0.25'] * 4, ['0.375'] * 4
            ],
            'div-sqrt': [
                ['2.25'] * 4, ['0.25'] * 4, ['6'] * 4
            ]
        }

    def single_binary_test(self, case):
        """Format a test case in 2 or 3 lines

        :param case: list of elements about the test case
        :return: test cases with 2 v128.const f32x4 operands, 3 lines at most
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
            result = self.v128_const(self.LANE_TYPE, case[-1])
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
        :return: test cases with 2 v128.const f32x4 operands, 2 lines at most
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

    def get_normal_case(self):
        """Normal test cases from WebAssembly core tests, 3 assert statements:
            assert_return
            assert_return_canonical_nan
            assert_return_arithmetic_nan
        """
        cases = []
        binary_test_data = []
        unary_test_data = []

        for op in self.BINARY_OPS:
            op_name = self.full_op_name(op)
            for p1 in self.FLOAT_NUMBERS:
                for p2 in self.FLOAT_NUMBERS:
                    result = binary_op(op, p1, p2)
                    if 'nan' not in result:
                        # Normal floating point numbers as the results
                        binary_test_data.append(['assert_return', op_name, p1, p2, result])
                    else:
                        # Since the results contain the 'nan' string, it should be in the
                        # assert_return_canonical_nan statements
                        binary_test_data.append(['assert_return_canonical_nan_f32x4', op_name, p1, p2])

            # assert_return_canonical_nan and assert_return_arithmetic_nan cases
            for p1 in self.NAN_NUMBERS:
                for p2 in self.FLOAT_NUMBERS:
                    if 'nan:' in p1 or 'nan:' in p2:
                        # When the arguments contain 'nan:', always use assert_return_arithmetic_nan
                        # statements for the cases. Since there 2 parameters for binary operation and
                        # the order of the parameters matter. Different order makes different cases.
                        binary_test_data.append(['assert_return_arithmetic_nan_f32x4', op_name, p1, p2])
                        binary_test_data.append(['assert_return_arithmetic_nan_f32x4', op_name, p2, p1])
                    else:
                        # No 'nan' string found, then it should be assert_return_canonical_nan.
                        binary_test_data.append(['assert_return_canonical_nan_f32x4', op_name, p1, p2])
                        binary_test_data.append(['assert_return_canonical_nan_f32x4', op_name, p2, p1])
                for p2 in self.NAN_NUMBERS:
                    # Both parameters contain 'nan', then there must be no assert_return.
                    if 'nan:' in p1 or 'nan:' in p2:
                        binary_test_data.append(['assert_return_arithmetic_nan_f32x4', op_name, p1, p2])
                    else:
                        binary_test_data.append(['assert_return_canonical_nan_f32x4', op_name, p1, p2])

        for case in binary_test_data:
            cases.append(self.single_binary_test(case))

        for p in self.FLOAT_NUMBERS + self.NAN_NUMBERS:
            if 'nan:' in p:
                unary_test_data.append(['assert_return_arithmetic_nan_f32x4', op_name, p])
            elif 'nan' in p:
                unary_test_data.append(['assert_return_canonical_nan_f32x4', op_name, p])
            else:
                # Normal floating point numbers for sqrt operation
                op_name = self.full_op_name('sqrt')
                result = float_sqrt(p)
                if 'nan' not in result:
                    # Get the sqrt value correctly
                    unary_test_data.append(['assert_return', op_name, p, result])
                else:
                    #
                    unary_test_data.append(['assert_return_canonical_nan_f32x4', op_name, p])

        for p in self.FLOAT_NUMBERS + self.NAN_NUMBERS:
            op_name = self.full_op_name('neg')
            result = float_neg(p)
            # Neg operation is valid for all the floating point numbers
            unary_test_data.append(['assert_return', op_name, p, result])

        for case in unary_test_data:
            cases.append(self.single_unary_test(case))

        self.mixed_nan_test(cases)

        return '\n'.join(cases)

    @property
    def mixed_sqrt_nan_test_data(self):
        return {
            "canon": [
                '-1.0 nan 4.0 9.0',
                ('nan', 'nan', '2.0', '3.0')
            ],
            'arith': [
                'nan:0x200000 -nan:0x200000 16.0 25.0',
                ('nan', 'nan', '4.0', '5.0')
            ],
            'mixed': [
                '-inf nan:0x200000 36.0 49.0',
                ('canon', 'arith', '6.0', '7.0')
            ]
        }

    def mixed_nan_test(self, cases):
        """Mixed f32x4 tests when only expects canonical NaNs in a subset of lanes.
        """
        mixed_cases = ['\n\n;; Mixed f32x4 tests when some lanes are NaNs', '(module\n']
        cases.extend(mixed_cases)
        for test_type, test_data in sorted(self.mixed_sqrt_nan_test_data.items()):
            func = ['  (func $f32x4_sqrt_{} (result v128)'.format(test_type),
                    '    v128.const f32x4 {}'.format(test_data[0]),
                    '    f32x4.sqrt)']
            cases.extend(func)
            for i, test in enumerate(test_data[1]):
                test = ['  (func (export "f32x4_extract_lane_{}_{}") (result f32)'.format(
                        test_type, i),
                        '    (f32x4.extract_lane {} (call $f32x4_sqrt_{})))'.format(
                        i, test_type)]
                cases.extend(test)
            cases.append('')
        cases.append(')\n')

        for test_type, test_data in sorted(self.mixed_sqrt_nan_test_data.items()):
            template = '({} (invoke "f32x4_extract_lane_{}_{}"))'
            for i, result in enumerate(test_data[1]):
                if test_type == 'canon' and result == 'nan':
                    cases.append(template.format(
                        'assert_return_canonical_nan', test_type, i))
                elif test_type == 'arith' and result == 'nan':
                    cases.append(template.format(
                        'assert_return_arithmetic_nan', test_type, i))
                elif result == 'canon':
                    cases.append(template.format(
                        'assert_return_canonical_nan', test_type, i))
                elif result == 'arith':
                    cases.append(template.format(
                        'assert_return_arithmetic_nan', test_type, i))
                else:
                    cases.append('({} (invoke "f32x4_extract_lane_{}_{}") '.format(
                        'assert_return', test_type, i) +
                                 '(f32.const {}))'.format(result))


def gen_test_cases():
    simd_f32x4_arith = Simdf32x4ArithmeticCase()
    simd_f32x4_arith.gen_test_cases()


if __name__ == '__main__':
    gen_test_cases()