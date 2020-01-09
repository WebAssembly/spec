#!/usr/bin/env python3

"""Base class for generating cases integer and floating-point numbers
arithmetic and saturate arithmetic operations.

Class SimdArithmeticCase is the base class of all kinds of arithmetic
operation cases. It provides a skeleton to generate the normal, invalid and
combined cases. Subclasses only provide the test data sets. In some special
cases, you may need to override the methods in base class to fulfill your
case generation.

Class LaneNumber and ArithmeticOp are used for calculating the results of
these arithmetic and saturate arithmetic operations.
"""

from simd import SIMD
from test_assert import AssertReturn, AssertInvalid


class LaneNumber:
    """This class stands for the number represented by a line in v128.
    Suppose a bit length of the lane is n, then:
    For signed integer:
        minimum = -pow(2, n - 1), maximum = pow(2, n - 1) - 1
    For unsigned integer:
        minimum = 0, maximum = pow(2, n) - 1
    The bit length of the lane can be 8, 16, 32, 64"""
    def __init__(self, length):
        """length: bit number of each lane in SIMD v128"""
        self.lane_len = length

    @property
    def min(self):
        return -pow(2, self.lane_len - 1)

    @property
    def max(self):
        return pow(2, self.lane_len - 1) - 1

    @property
    def mask(self):
        return pow(2, self.lane_len) - 1

    @property
    def mod(self):
        return pow(2, self.lane_len)

    @property
    def quarter(self):
        return pow(2, self.lane_len - 2)


i8 = LaneNumber(8)
i16 = LaneNumber(16)
i32 = LaneNumber(32)
i64 = LaneNumber(64)


class ArithmeticOp:
    """This class stands for an SIMD integer operator, with one or
    more operands. The methods are some kind of arithmetic with the
    operands.
    """
    def __init__(self, op):
        self.op = op

    @staticmethod
    def get_valid_lane(value, lane):
        """Get the valid integer number of value in the specified lane size.
        """
        value &= lane.mask
        if value > lane.max:
            return value - lane.mod
        if value < lane.min:
            return value + lane.mod
        return value

    def saturate(self, p1, p2, lane):
        """Get the result of saturate arithmetic operation of 2 operands.
        Supports both signed and unsigned number.
        """
        if self.op.endswith('saturate_s'):
            if p1 > lane.max:
                p1 -= lane.mod
            if p2 > lane.max:
                p2 -= lane.mod

            if self.op.startswith('add'):
                value = p1 + p2
            if self.op.startswith('sub'):
                value = p1 - p2

            if value > lane.max:
                return lane.max
            if value < lane.min:
                return lane.min

        if self.op.endswith('saturate_u'):
            if p1 < 0:
                p1 += lane.mod
            if p2 < 0:
                p2 += lane.mod
            if self.op.startswith('add'):
                value = p1 + p2
            if self.op.startswith('sub'):
                value = p1 - p2

            if value > lane.mask:
                return lane.mask
            if value < 0:
                return 0

        return value

    def unary_op(self, p, lane):
        """General unary arithmetic operation."""
        if isinstance(p, str) and '0x' in p:
            p = int(p, base=16)
        if self.op == 'neg':
            value = -p
        return self.get_valid_lane(value, lane)

    def binary_op(self, p1, p2, lane, float_repr=False):
        """General binary arithmetic operation for 2 numbers."""
        if isinstance(p1, str) and '0x' in p1:
            p1 = int(p1, base=16)
        if isinstance(p2, str) and '0x' in p2:
            p2 = int(p2, base=16)

        if float_repr:
            p2 &= lane.mask

        if self.op == 'add':
            value = (p1 + p2)
        elif self.op == 'sub':
            value = (p1 - p2)
        elif self.op == 'mul':
            value = (p1 * p2)
        elif 'saturate' in self.op:
            return self.saturate(p1, p2, lane)
        else:
            raise Exception('Unsupported operator: %s' % self.op)

        return self.get_valid_lane(value, lane)


class SimdArithmeticCase:

    UNARY_OPS = ('neg',)
    BINARY_OPS = ('add', 'sub', 'mul')
    LANE_NUMBER = {'i8x16': i8, 'i16x8': i16, 'i32x4': i32, 'i64x2': i64}

    def __str__(self):
        return self.get_all_cases()

    @property
    def lane(self):
        return self.LANE_NUMBER.get(self.LANE_TYPE)

    @property
    def normal_unary_op_test_data(self):
        lane = self.lane
        return [0, 1, -1, lane.max - 1, lane.min + 1, lane.min, lane.max, lane.mask]

    @property
    def normal_binary_op_test_data(self):
        lane = self.lane
        return [
            (0, 0),
            (0, 1),
            (1, 1),
            (0, -1),
            (1, -1),
            (-1, -1),
            (lane.quarter - 1, lane.quarter),
            (lane.quarter, lane.quarter),
            (-lane.quarter + 1, -lane.quarter),
            (-lane.quarter, -lane.quarter),
            (-lane.quarter - 1, -lane.quarter),
            (lane.max - 2, 1),
            (lane.max - 1, 1),
            (-lane.min, 1),
            (lane.min + 2, -1),
            (lane.min + 1, -1),
            (lane.min, -1),
            (lane.max, lane.max),
            (lane.min, lane.min),
            (lane.min, lane.min + 1),
            (lane.mask, 0),
            (lane.mask, 1),
            (lane.mask, -1),
            (lane.mask, lane.max),
            (lane.mask, lane.min),
            (lane.mask, lane.mask)
        ]

    @property
    def bin_test_data(self):
        return [
            (self.normal_binary_op_test_data, [self.LANE_TYPE] * 3),
            (self.hex_binary_op_test_data, [self.LANE_TYPE] * 3)
        ]

    @property
    def unary_test_data(self):
        return [
            (self.normal_unary_op_test_data, [self.LANE_TYPE] * 2),
            (self.hex_unary_op_test_data, [self.LANE_TYPE] * 2)
        ]

    @property
    def combine_ternary_arith_test_data(self):
        return {
            'add-sub': [
                [str(i) for i in range(self.LANE_LEN)],
                [str(i * 2) for i in range(self.LANE_LEN)],
                [str(i * 2) for i in range(self.LANE_LEN)],
                [str(i) for i in range(self.LANE_LEN)]
            ],
            'sub-add': [
                [str(i) for i in range(self.LANE_LEN)],
                [str(i * 2) for i in range(self.LANE_LEN)],
                [str(i * 2) for i in range(self.LANE_LEN)],
                [str(i) for i in range(self.LANE_LEN)]
            ],
            'mul-add': [
                [str(i) for i in range(self.LANE_LEN)],
                [str(i) for i in range(self.LANE_LEN)],
                ['2'] * self.LANE_LEN,
                [str(i * 4) for i in range(self.LANE_LEN)]
            ],
            'mul-sub': [
                [str(i * 2) for i in range(self.LANE_LEN)],
                [str(i) for i in range(self.LANE_LEN)],
                [str(i) for i in range(self.LANE_LEN)],
                [str(pow(i, 2)) for i in range(self.LANE_LEN)]
            ]
        }

    @property
    def combine_binary_arith_test_data(self):
        return {
            'add-neg': [
                [str(i) for i in range(self.LANE_LEN)],
                [str(i) for i in range(self.LANE_LEN)],
                ['0'] * self.LANE_LEN
            ],
            'sub-neg': [
                [str(i) for i in range(self.LANE_LEN)],
                [str(i) for i in range(self.LANE_LEN)],
                [str(-i * 2) for i in range(self.LANE_LEN)]
            ],
            'mul-neg': [
                [str(i) for i in range(self.LANE_LEN)],
                ['2'] * self.LANE_LEN,
                [str(-i * 2) for i in range(self.LANE_LEN)]
            ]
        }

    def gen_test_func_template(self):
        template = [
            ';; Tests for {} arithmetic operations on major boundary values and all special values.\n\n'.format(
                self.LANE_TYPE), '(module']

        for op in self.BINARY_OPS:
            template.append('  (func (export "{lane_type}.%s") (param v128 v128) (result v128) '
                            '({lane_type}.%s (local.get 0) (local.get 1)))' % (op, op))
        for op in self.UNARY_OPS:
            template.append('  (func (export "{lane_type}.%s") (param v128) (result v128) '
                            '({lane_type}.%s (local.get 0)))' % (op, op))

        template.append(')\n')
        return template

    def gen_test_template(self):
        template = self.gen_test_func_template()

        template.append('{normal_cases}')
        template.append('\n{invalid_cases}')
        template.append('\n{combine_cases}')

        return '\n'.join(template)

    def get_case_data(self):
        case_data = []

        # i8x16.op (i8x16) (i8x16)
        for op in self.BINARY_OPS:
            o = ArithmeticOp(op)
            op_name = self.LANE_TYPE + '.' + op
            case_data.append(['#', op_name])
            for data_group, v128_forms in self.bin_test_data:
                for data in data_group:
                    case_data.append([op_name, [str(data[0]), str(data[1])],
                                      str(o.binary_op(data[0], data[1], self.lane)),
                                     v128_forms])
            for data_group in self.full_bin_test_data:
                for data in data_group.get(op_name):
                    case_data.append([op_name, *data])

        for op in self.UNARY_OPS:
            o = ArithmeticOp(op)
            op_name = self.LANE_TYPE + '.' + op
            case_data.append(['#', op_name])
            for data_group, v128_forms in self.unary_test_data:
                for data in data_group:
                    case_data.append([op_name, [str(data)],
                                      str(o.unary_op(data, self.lane)),
                                      v128_forms])

        return case_data

    def get_invalid_cases(self):
        invalid_cases = [';; type check']
        unary_template = '(assert_invalid (module (func (result v128) '\
                         '({lane_type}.{op} ({operand})))) "type mismatch")'
        binary_template = '(assert_invalid (module (func (result v128) '\
                          '({lane_type}.{op} ({operand_1}) ({operand_2})))) "type mismatch")'

        for op in self.UNARY_OPS:
            invalid_cases.append(unary_template.format(lane_type=self.LANE_TYPE, op=op,
                                                       operand='i32.const 0'))
        for op in self.BINARY_OPS:
            invalid_cases.append(binary_template.format(lane_type=self.LANE_TYPE, op=op,
                                                        operand_1='i32.const 0',
                                                        operand_2='f32.const 0.0'))

        return '\n'.join(invalid_cases) + self.argument_empty_test()

    def argument_empty_test(self):
        """Test cases with empty argument.
        """
        cases = []

        cases.append('\n\n;; Test operation with empty argument\n')

        case_data = {
            'op': '',
            'extended_name': 'arg-empty',
            'param_type': '',
            'result_type': '(result v128)',
            'params': '',
        }

        for op in self.UNARY_OPS:
            case_data['op'] = '{lane_type}.{op}'.format(lane_type=self.LANE_TYPE, op=op)
            case_data['extended_name'] = 'arg-empty'
            case_data['params'] = ''
            cases.append(AssertInvalid.get_arg_empty_test(**case_data))

        for op in self.BINARY_OPS:
            case_data['op'] = '{lane_type}.{op}'.format(lane_type=self.LANE_TYPE, op=op)
            case_data['extended_name'] = '1st-arg-empty'
            case_data['params'] = SIMD.v128_const('0', self.LANE_TYPE)
            cases.append(AssertInvalid.get_arg_empty_test(**case_data))

            case_data['extended_name'] = 'arg-empty'
            case_data['params'] = ''
            cases.append(AssertInvalid.get_arg_empty_test(**case_data))

        return '\n'.join(cases)

    def get_combine_cases(self):
        combine_cases = [';; combination\n(module']
        ternary_func_template = '  (func (export "{func}") (param v128 v128 v128) (result v128)\n' \
                              '    ({lane}.{op1} ({lane}.{op2} (local.get 0) (local.get 1))'\
                              '(local.get 2)))'
        for func in sorted(self.combine_ternary_arith_test_data):
            func_parts = func.split('-')
            combine_cases.append(ternary_func_template.format(func=func,
                                                            lane=self.LANE_TYPE,
                                                            op1=func_parts[0],
                                                            op2=func_parts[1]))
        binary_func_template = '  (func (export "{func}") (param v128 v128) (result v128)\n'\
                             '    ({lane}.{op1} ({lane}.{op2} (local.get 0)) (local.get 1)))'
        for func in sorted(self.combine_binary_arith_test_data):
            func_parts = func.split('-')
            combine_cases.append(binary_func_template.format(func=func,
                                                           lane=self.LANE_TYPE,
                                                           op1=func_parts[0],
                                                           op2=func_parts[1]))
        combine_cases.append(')\n')
        ternary_case_template = ('(assert_return (invoke "{func}" ',
                                 '(v128.const {lane_type_1} {val_1})',
                                 '(v128.const {lane_type_2} {val_2})',
                                 '(v128.const {lane_type_3} {val_3}))',
                                 '(v128.const {lane_type_4} {val_4}))')
        for func, test in sorted(self.combine_ternary_arith_test_data.items()):
            line_head = ternary_case_template[0].format(func=func)
            line_head_len = len(line_head)
            blank_head = ' ' * line_head_len
            combine_cases.append('\n'.join([
                line_head + ternary_case_template[1].format(
                    lane_type_1=self.LANE_TYPE, val_1=' '.join(test[0])),
                blank_head + ternary_case_template[2].format(
                    lane_type_2=self.LANE_TYPE, val_2=' '.join(test[1])),
                blank_head + ternary_case_template[3].format(
                    lane_type_3=self.LANE_TYPE, val_3=' '.join(test[2])),
                blank_head + ternary_case_template[4].format(
                    lane_type_4=self.LANE_TYPE, val_4=' '.join(test[3]))]))
        binary_case_template = ('(assert_return (invoke "{func}" ',
                                '(v128.const {lane_type_1} {val_1})',
                                '(v128.const {lane_type_2} {val_2}))',
                                '(v128.const {lane_type_3} {val_3}))')
        for func, test in sorted(self.combine_binary_arith_test_data.items()):
            line_head = binary_case_template[0].format(func=func)
            line_head_len = len(line_head)
            blank_head = ' ' * line_head_len
            combine_cases.append('\n'.join([
                line_head + binary_case_template[1].format(
                    lane_type_1=self.LANE_TYPE, val_1=' '.join(test[0])),
                blank_head + binary_case_template[2].format(
                    lane_type_2=self.LANE_TYPE, val_2=' '.join(test[1])),
                blank_head + binary_case_template[3].format(
                    lane_type_3=self.LANE_TYPE, val_3=' '.join(test[2]))]))
        return '\n'.join(combine_cases)

    def get_normal_case(self):
        s = SIMD()
        case_data = self.get_case_data()
        cases = []

        for item in case_data:
            # Recognize '#' as a commentary
            if item[0] == '#':
                cases.append('\n;; {}'.format(item[1]))
                continue

            instruction, param, ret, lane_type = item
            v128_result = s.v128_const(ret, lane_type[-1])
            v128_params = []
            for i, p in enumerate(param):
                v128_params.append(s.v128_const(p, lane_type[i]))
            cases.append(str(AssertReturn(instruction, v128_params, v128_result)))

        return '\n'.join(cases)

    def get_all_cases(self):
        case_data = {'lane_type': self.LANE_TYPE,
                     'normal_cases': self.get_normal_case(),
                     'invalid_cases': self.get_invalid_cases(),
                     'combine_cases': self.get_combine_cases()
                     }
        return self.gen_test_template().format(**case_data)

    def gen_test_cases(self):
        wast_filename = '../simd_{lane_type}_arith.wast'.format(lane_type=self.LANE_TYPE)
        with open(wast_filename, 'w') as fp:
            fp.write(self.get_all_cases())
