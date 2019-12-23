#!/usr/bin/env python3

"""
Generate [min_s, min_u, max_s, max_u] cases for i32x4, i16x8 and i8x16.
"""

from simd import SIMD
from test_assert import AssertReturn
from simd_lane_value import LaneValue
from simd_integer_op import IntegerSimpleOp as IntOp


class SimdLaneWiseInteger:
    LANE_TYPE = None

    LANE_VALUE = None

    BINARY_OPS = ('min_s', 'min_u', 'max_s', 'max_u',)

    class_summary = """;; Tests for {lane_type} [min_s, min_u, max_s, max_u] operations."""

    def __init__(self):

        self.LANE_VALUE = LaneValue(self.lane_width)

    @property
    def lane_count(self):
        """count of lanes"""
        return int(self.LANE_TYPE.split('x')[1])

    @property
    def lane_width(self):
        """width of a single lane"""
        return int(self.LANE_TYPE.replace('i', '').split('x')[0])

    @property
    def get_test_data_with_const(self):
        """test const vs const and param vs const"""
        case_data = [
            [
                [self.LANE_VALUE.min, self.LANE_VALUE.max, self.LANE_VALUE.quarter, self.LANE_VALUE.mask],
                [self.LANE_VALUE.mask, self.LANE_VALUE.quarter, self.LANE_VALUE.max, self.LANE_VALUE.min]
            ],
            [
                [0, 1, 2, 3],
                [3, 2, 1, 0],
            ]
        ]
        case_data = [[list(map(str, param_1)), list(map(str, param_2))] for param_1, param_2 in case_data]

        return case_data

    @property
    def get_test_data_go_through_if(self):
        """test different lanes go through different if-then clauses"""
        case_data = [
            [
                [self.LANE_VALUE.min, self.LANE_VALUE.max, self.LANE_VALUE.quarter, self.LANE_VALUE.mask],
                [self.LANE_VALUE.mask, self.LANE_VALUE.quarter, self.LANE_VALUE.max, self.LANE_VALUE.min]
            ],
            [
                [0, 1, 2, 128],
                [0, 2, 1, 0x80],
            ]
        ]
        case_data = [[list(map(str, param_1)), list(map(str, param_2))] for param_1, param_2 in case_data]

        return case_data

    @property
    def get_test_data_opposite_sign_zero(self):
        """test opposite signs of zero"""
        case_data = [
            [
                ['-0', '-0', '+0', '+0'],
                ['+0', '0', '-0', '0'],
            ],
            [
                ['-0', '-0', '-0', '-0'],
                ['+0', '+0', '+0', '+0'],
            ]
        ]

        return case_data

    @property
    def get_test_data(self):
        """case data"""

        case_data = [

            [
                ['0'] * self.lane_count,
                ['0'] * self.lane_count,
            ],
            [
                ['0'] * self.lane_count,
                ['-1'] * self.lane_count,
            ],
            [
                ['0', '0', '-1', '-1'],
                ['0', '-1', '0', '-1'],
            ],
            [
                ['0'] * self.lane_count,
                [hex(self.LANE_VALUE.mask)] * self.lane_count,
            ],

            [
                ['1'] * self.lane_count,
                ['1'] * self.lane_count,
            ],
            [
                [str(self.LANE_VALUE.mask)] * self.lane_count,
                ['1'] * self.lane_count,
            ],
            [
                [str(self.LANE_VALUE.mask)] * self.lane_count,
                ['128'] * self.lane_count,
            ],
            [
                [str(-self.LANE_VALUE.min)] * self.lane_count,
                [str(self.LANE_VALUE.min)] * self.lane_count,
            ],
            [
                [hex(-self.LANE_VALUE.min)] * self.lane_count,
                [str(self.LANE_VALUE.min)] * self.lane_count,
            ],
            [
                ['123'] * self.lane_count,
                ['01_2_3'] * self.lane_count,
            ],
            [
                ['0x80'] * self.lane_count,
                ['0x0_8_0'] * self.lane_count,
            ],

        ]

        return case_data

    @property
    def gen_funcs_normal(self):
        """generate normal functions"""
        binary_func_template = '\n  (func (export "{lane_type}.{op}") (param v128 v128) (result v128) ({lane_type}.{op} (local.get 0) (local.get 1)))'
        funcs = ''
        for op in self.BINARY_OPS:
            funcs += binary_func_template.format(lane_type=self.LANE_TYPE, op=op)

        return funcs

    @property
    def gen_funcs_with_const(self):
        """generate functions with const arguments"""
        func_with_const = '\n  (func (export "{lane_type}.{op}_with_const_{cnt}") (result v128) ({lane_type}.{op} {param_1} {param_2}))'
        func_with_param_and_const = '\n  (func (export "{lane_type}.{op}_with_const_{cnt}") (param v128) (result v128) ({lane_type}.{op} (local.get 0) {param_1}))'
        funcs = ''
        cnt = 0
        for op in self.BINARY_OPS:
            for param_1, param_2 in self.get_test_data_with_const:
                funcs += func_with_const.format(lane_type=self.LANE_TYPE,
                                                op=op,
                                                param_1=SIMD.v128_const(param_1, self.LANE_TYPE),
                                                param_2=SIMD.v128_const(param_2, self.LANE_TYPE),
                                                cnt=cnt)
                cnt += 1

        for op in self.BINARY_OPS:
            for param_1, param_2 in self.get_test_data_with_const:
                funcs += func_with_param_and_const.format(lane_type=self.LANE_TYPE,
                                                          op=op,
                                                          param_1=SIMD.v128_const(param_1, self.LANE_TYPE),
                                                          cnt=cnt)
                cnt += 1

        return funcs

    @property
    def gen_test_case_with_const(self):
        """generate tests calling function with const"""
        cnt = 0
        cases = '\n\n;; Const vs const'
        for op in self.BINARY_OPS:
            for param_1, param_2 in self.get_test_data_with_const:
                result = []
                for idx in range(0, len(param_1)):
                    result.append(IntOp.binary_op(op, param_1[idx], param_2[idx], self.lane_width))
                cases += '\n' + str(AssertReturn('{lane_type}.{op}_with_const_{cnt}'.format(lane_type=self.LANE_TYPE, op=op, cnt=cnt),
                                                 [],
                                                 SIMD.v128_const(result, self.LANE_TYPE)))
                cnt += 1

        cases += '\n\n;; Param vs const'
        for op in self.BINARY_OPS:
            for param_1, param_2 in self.get_test_data_with_const:
                result = []
                for idx in range(0, len(param_1)):
                    result.append(IntOp.binary_op(op, param_1[idx], param_2[idx], self.lane_width))
                cases += '\n' + str(AssertReturn('{lane_type}.{op}_with_const_{cnt}'.format(lane_type=self.LANE_TYPE, op=op, cnt=cnt),
                                                 [SIMD.v128_const(param_2, self.LANE_TYPE)],
                                                 SIMD.v128_const(result, self.LANE_TYPE)))
                cnt += 1

        return cases

    @property
    def gen_test_case(self):
        """generate test cases"""
        cases = ''

        def gen(case_data):
            cases = ''
            for op in self.BINARY_OPS:
                for param_1, param_2 in case_data:
                    result = []
                    for idx in range(0, len(param_1)):
                        result.append(IntOp.binary_op(op, param_1[idx], param_2[idx], self.lane_width))
                    cases += '\n' + str(AssertReturn('{lane_type}.{op}'.format(lane_type=self.LANE_TYPE, op=op),
                                                     [SIMD.v128_const(param_1, self.LANE_TYPE), SIMD.v128_const(param_2, self.LANE_TYPE)],
                                                     SIMD.v128_const(result, self.LANE_TYPE)))
            return cases

        cases += gen(self.get_test_data)

        cases += self.gen_test_case_with_const

        # test different lanes go through different if-then clauses
        cases += '\n\n;; Test different lanes go through different if-then clauses'
        cases += gen(self.get_test_data_go_through_if)

        # test opposite signs of zero
        cases += '\n\n;; Test opposite signs of zero'
        cases += gen(self.get_test_data_opposite_sign_zero)

        # unknown operators test cases
        cases += self.gen_test_case_unknown_operators

        # type check test cases
        cases += self.gen_test_case_type_check

        # empty argument test cases
        cases += self.gen_test_case_empty_argument

        return cases

    @property
    def gen_test_case_unknown_operators(self):
        """generate unknown operators test cases"""

        if self.LANE_TYPE != 'i32x4':
            return ''

        cases = '\n\n;; Unknown operators'
        lane_types = ('f32x4', 'i64x2',)
        assert_template = '(assert_malformed (module quote "(memory 1) (func (result v128) ({lane_type}.{op} {param_1} {param_2}))") "unknown operator")'
        for lane_type in lane_types:
            for op in self.BINARY_OPS:
                cases += '\n' + assert_template.format(lane_type=lane_type,
                                                       op=op,
                                                       param_1=SIMD.v128_const('0', self.LANE_TYPE),
                                                       param_2=SIMD.v128_const('1', self.LANE_TYPE))

        return cases

    @property
    def gen_test_case_type_check(self):
        """generate type check test cases"""
        cases = '\n\n;; Type check'
        assert_template = '(assert_invalid (module (func (result v128) ({lane_type}.{op} (i32.const 0) (f32.const 0.0)))) "type mismatch")'
        for op in self.BINARY_OPS:
            cases += '\n' + assert_template.format(lane_type=self.LANE_TYPE, op=op)

        return cases

    @property
    def gen_funcs_combination(self):
        """generate functions for combination test cases"""
        funcs = '\n\n;; Combination'
        funcs += '\n(module'

        assert_template = '  (func (export "{lane_type}.{op1}-{lane_type}.{op2}") (param v128 v128 v128) (result v128) ' \
                          '({lane_type}.{op1} ({lane_type}.{op2} (local.get 0) (local.get 1))(local.get 2))' \
                          ')'

        binary_ops = list(self.BINARY_OPS)
        binary_ops.reverse()
        for op1 in self.BINARY_OPS:
            for op2 in binary_ops:
                funcs += '\n' + assert_template.format(lane_type=self.LANE_TYPE, op1=op1, op2=op2)

        funcs += '\n)'
        return funcs

    @property
    def gen_test_case_combination(self):
        """generate combination test cases"""

        cases = '\n'

        binary_ops = list(self.BINARY_OPS)
        binary_ops.reverse()
        for op1 in self.BINARY_OPS:
            for op2 in binary_ops:

                result = []
                ret = IntOp.binary_op(op2, '0', '1', self.lane_width)
                ret = IntOp.binary_op(op1, ret, '2', self.lane_width)
                result.append(ret)

                cases += '\n' + str(AssertReturn('{lane_type}.{op1}-{lane_type}.{op2}'.format(lane_type=self.LANE_TYPE, op1=op1, op2=op2),
                                                 [SIMD.v128_const('0', self.LANE_TYPE),
                                                  SIMD.v128_const('1', self.LANE_TYPE),
                                                  SIMD.v128_const('2', self.LANE_TYPE)],
                                                 SIMD.v128_const(result, self.LANE_TYPE)))
        cases += '\n'
        return cases

    @property
    def gen_test_case_empty_argument(self):
        """generate empty argument test cases"""

        assert_1st_empyt_template = '\n(assert_invalid' \
                                    '\n  (module' \
                                    '\n    (func ${lane_type}.{op}-1st-arg-empty (result v128)' \
                                    '\n      ({lane_type}.{op} {param_1})' \
                                    '\n    )' \
                                    '\n  )' \
                                    '\n  "type mismatch"' \
                                    '\n)'
        assert_all_empty_template = '\n(assert_invalid' \
                                    '\n  (module' \
                                    '\n    (func ${lane_type}.{op}-all-args-empty (result v128)' \
                                    '\n      ({lane_type}.{op})' \
                                    '\n    )' \
                                    '\n  )' \
                                    '\n  "type mismatch"' \
                                    '\n)'

        cases = ''

        cases += '\n\n;; Test operation with empty argument\n'
        for op in self.BINARY_OPS:
            cases += assert_1st_empyt_template.format(lane_type=self.LANE_TYPE, op=op, param_1=SIMD.v128_const('0', self.LANE_TYPE))
            cases += assert_all_empty_template.format(lane_type=self.LANE_TYPE, op=op)

        return cases

    @property
    def gen_funcs(self):
        """generate functions"""
        funcs = ''
        funcs += '\n\n(module'
        funcs += self.gen_funcs_normal
        funcs += self.gen_funcs_with_const
        funcs += '\n)\n'

        return funcs

    def get_all_cases(self):
        """generate all test cases"""
        cases = self.class_summary.format(lane_type=self.LANE_TYPE) \
            + self.gen_funcs \
            + self.gen_test_case \
            + self.gen_funcs_combination \
            + self.gen_test_case_combination

        return cases

    def gen_test_cases(self):
        """generate case file"""
        wast_filename = '../simd_{lane_type}_arith2.wast'.format(lane_type=self.LANE_TYPE)
        with open(wast_filename, 'w') as fp:
            fp.write(self.get_all_cases())


class Simdi32x4Case(SimdLaneWiseInteger):
    LANE_TYPE = 'i32x4'


class Simdi16x8Case(SimdLaneWiseInteger):
    LANE_TYPE = 'i16x8'


class Simdi8x16Case(SimdLaneWiseInteger):
    LANE_TYPE = 'i8x16'


def gen_test_cases():
    simd_i32x4_case = Simdi32x4Case()
    simd_i32x4_case.gen_test_cases()

    simd_i16x8_case = Simdi16x8Case()
    simd_i16x8_case.gen_test_cases()

    simd_i8x16_case = Simdi8x16Case()
    simd_i8x16_case.gen_test_cases()


if __name__ == '__main__':
    gen_test_cases()