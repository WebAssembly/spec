#!/usr/bin/env python3

"""
Generate f32x4 [abs, min, max] cases.
"""

from simd_f32x4_arith import Simdf32x4ArithmeticCase
from simd import SIMD
from test_assert import AssertReturn


def binary_op(op: str, p1: str, p2: str) -> str:
    """Binary operation on p1 and p2 with the operation specified by op

    :param op: min, max,
    :param p1: float number in hex
    :param p2: float number in hex
    :return:
    """
    f1 = float.fromhex(p1)
    f2 = float.fromhex(p2)

    if '-nan' in [p1, p2] and 'nan' in [p1, p2]:
        return p1

    if 'nan' in [p1, p2]:
        return 'nan'

    if '-nan' in [p1, p2]:
        return '-nan'

    if op == 'min':
        if '-0x0p+0' in [p1, p2] and '0x0p+0' in [p1, p2]:
            return '-0x0p+0'
        result = min(f1, f2)

    elif op == 'max':
        if '-0x0p+0' in [p1, p2] and '0x0p+0' in [p1, p2]:
            return '0x0p+0'
        result = max(f1, f2)

    else:
        raise Exception('Unknown binary operation: {}'.format(op))

    return result.hex()


def unary_op(op: str, p1: str) -> str:
    """Unnary operation on p1 with the operation specified by op

    :param op: abs,
    :param p1: float number in hex
    :return:
    """
    f1 = float.fromhex(p1)
    if op == 'abs':
        return abs(f1).hex()

    raise Exception('Unknown unary operation: {}'.format(op))


class Simdf32x4Case(Simdf32x4ArithmeticCase):
    UNARY_OPS = ('abs',)
    BINARY_OPS = ('min', 'max',)

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

        return SIMD().v128_const(val, lane)

    def gen_test_fn_template(self):

        # Get function code
        template = Simdf32x4ArithmeticCase.gen_test_fn_template(self)

        # Function template
        tpl_func = '  (func (export "{}"){} (result v128) ({} {}{}))'

        # Const data for min and max
        lst_instr_with_const = [
            [
                [['0', '1', '2', '-3'], ['0', '2', '1', '3']],
                [['0', '1', '1', '-3'], ['0', '2', '2', '3']]
            ],
            [
                [['0', '1', '2', '3'], ['0', '1', '2', '3']],
                [['0', '1', '2', '3'], ['0', '1', '2', '3']]
            ],
            [
                [['0x00', '0x01', '0x02', '0x80000000'], ['0x00', '0x02', '0x01', '2147483648']],
                [['0x00', '0x01', '0x01', '0x80000000'], ['0x00', '0x02', '0x02', '2147483648']]
            ],
            [
                [['0x00', '0x01', '0x02', '0x80000000'], ['0x00', '0x01', '0x02', '0x80000000']],
                [['0x00', '0x01', '0x02', '0x80000000'], ['0x00', '0x01', '0x02', '0x80000000']]
            ]
        ]

        # Assert data
        lst_oprt_with_const_assert = {}

        # Generate func and assert
        for op in self.BINARY_OPS:

            op_name = self.full_op_name(op)

            # Add comment for the case script "  ;; [f32x4.min, f32x4.max] const vs const"
            template.insert(len(template)-1, '  ;; {} const vs const'.format(op_name))

            # Add const vs const cases
            for case_data in lst_instr_with_const:

                func_name = "{}_with_const_{}".format(op_name, len(template)-7)
                template.insert(len(template)-1,
                                tpl_func.format(func_name, '', op_name,
                                                self.v128_const('f32x4', case_data[0][0]),
                                                ' ' + self.v128_const('f32x4', case_data[0][1])))

                ret_idx = 0 if op == 'min' else 1

                if op not in lst_oprt_with_const_assert:
                    lst_oprt_with_const_assert[op] = []

                lst_oprt_with_const_assert[op].append([func_name, case_data[1][ret_idx]])

            # Add comment for the case script "  ;; [f32x4.min, f32x4.max] param vs const"
            template.insert(len(template)-1, '  ;; {} param vs const'.format(op_name))

            case_cnt = 0

            # Add param vs const cases
            for case_data in lst_instr_with_const:

                func_name = "{}_with_const_{}".format(op_name, len(template)-7)

                # Cross parameters and constants
                if case_cnt in (0, 3):
                    func_param_0 = '(local.get 0)'
                    func_param_1 = self.v128_const('f32x4', case_data[0][0])
                else:
                    func_param_0 = self.v128_const('f32x4', case_data[0][0])
                    func_param_1 = '(local.get 0)'

                template.insert(len(template)-1,
                                tpl_func.format(func_name, '(param v128)', op_name, func_param_0, ' ' + func_param_1))

                ret_idx = 0 if op == 'min' else 1

                if op not in lst_oprt_with_const_assert:
                    lst_oprt_with_const_assert[op] = []

                lst_oprt_with_const_assert[op].append([func_name, case_data[0][1], case_data[1][ret_idx]])

                case_cnt += 1

        # Generate func for abs
        op_name = self.full_op_name('abs')
        func_name = "{}_with_const".format(op_name)
        template.insert(len(template)-1, '')
        template.insert(len(template)-1,
                        tpl_func.format(func_name, '', op_name,
                                        self.v128_const('f32x4', ['-0', '-1', '-2', '-3']), ''))

        # Test different lanes go through different if-then clauses
        lst_diff_lane_vs_clause = [
            [
                'f32x4.min',
                [['nan', '0', '0', '1'], ['0', '-nan', '1', '0']],
                [['nan', '-nan', '0', '0']],
                ['f32x4', 'f32x4', 'f32x4']
            ],
            [
                'f32x4.min',
                [['nan', '0', '0', '0'], ['0', '-nan', '1', '0']],
                [['nan', '-nan', '0', '0']],
                ['f32x4', 'f32x4', 'f32x4']
            ],
            [
                'f32x4.max',
                [['nan', '0', '0', '1'], ['0', '-nan', '1', '0']],
                [['nan', '-nan', '1', '1']],
                ['f32x4', 'f32x4', 'f32x4']
            ],
            [
                'f32x4.max',
                [['nan', '0', '0', '0'], ['0', '-nan', '1', '0']],
                [['nan', '-nan', '1', '0']],
                ['f32x4', 'f32x4', 'f32x4']
            ]
        ]

        # Case number
        case_cnt = 0

        # Template for func name to extract a lane
        tpl_func_name_by_lane = 'call_indirect_vv_v_f32x4_extract_lane_{}'

        # Template for assert
        tpl_assert = '({}\n' \
                     '  (invoke "{}"\n' \
                     '    {}\n' \
                     '    {}\n' \
                     '    {}\n' \
                     '  )\n' \
                     '{}' \
                     ')'

        lst_diff_lane_vs_clause_assert = []

        # Add comment in wast script
        lst_diff_lane_vs_clause_assert.append('')
        lst_diff_lane_vs_clause_assert.append(';; Test different lanes go through different if-then clauses')

        template.insert(len(template)-1, '')
        template.insert(len(template)-1, '  ;;  Test different lanes go through different if-then clauses')

        # Add test case for test different lanes go through different if-then clauses
        template.insert(len(template)-1, '  (type $vv_v (func (param v128 v128) (result v128)))\n'
                                         '  (table funcref (elem $f32x4_min $f32x4_max))\n'
                                         '\n'
                                         '  (func $f32x4_min (type $vv_v)\n'
                                         '    (f32x4.min (local.get 0) (local.get 1))\n'
                                         '  )\n'
                                         '\n'
                                         '  (func $f32x4_max (type $vv_v)\n'
                                         '    (f32x4.max (local.get 0) (local.get 1))\n'
                                         '  )\n'
                                         '\n'
                                         '  (func (export "call_indirect_vv_v_f32x4_extract_lane_0")\n'
                                         '    (param v128 v128 i32) (result f32)\n'
                                         '    (f32x4.extract_lane 0\n'
                                         '      (call_indirect (type $vv_v) (local.get 0) (local.get 1) (local.get 2))\n'
                                         '    )\n'
                                         '  )\n'
                                         '  (func (export "call_indirect_vv_v_f32x4_extract_lane_1")\n'
                                         '    (param v128 v128 i32) (result f32)\n'
                                         '    (f32x4.extract_lane 1\n'
                                         '      (call_indirect (type $vv_v) (local.get 0) (local.get 1) (local.get 2))\n'
                                         '    )\n'
                                         '  )\n'
                                         '  (func (export "call_indirect_vv_v_f32x4_extract_lane_2")\n'
                                         '    (param v128 v128 i32) (result f32)\n'
                                         '    (f32x4.extract_lane 2\n'
                                         '      (call_indirect (type $vv_v) (local.get 0) (local.get 1) (local.get 2))\n'
                                         '    )\n'
                                         '  )\n'
                                         '  (func (export "call_indirect_vv_v_f32x4_extract_lane_3")\n'
                                         '    (param v128 v128 i32) (result f32)\n'
                                         '    (f32x4.extract_lane 3\n'
                                         '      (call_indirect (type $vv_v) (local.get 0) (local.get 1) (local.get 2))\n'
                                         '    )\n'
                                         '  )')

        for case_data in lst_diff_lane_vs_clause:

            lst_diff_lane_vs_clause_assert.append(';; {} {}'.format(case_data[0], case_cnt))

            # generate assert for every data lane
            for lane_idx in range(0, len(case_data[2][0])):

                # get the result by lane
                ret = case_data[2][0][lane_idx]

                idx_func = '0' if 'min' in case_data[0] else '1'

                # append assert
                if 'nan' in ret:

                    lst_diff_lane_vs_clause_assert.append(tpl_assert.format('assert_return_canonical_nan',
                                                                            tpl_func_name_by_lane.format(lane_idx),
                                                                            self.v128_const('f32x4', case_data[1][0]),
                                                                            self.v128_const('f32x4', case_data[1][1]),
                                                                            self.v128_const('i32', idx_func),
                                                                            ''))
                else:

                    lst_diff_lane_vs_clause_assert.append(tpl_assert.format('assert_return',
                                                                            tpl_func_name_by_lane.format(lane_idx),
                                                                            self.v128_const('f32x4', case_data[1][0]),
                                                                            self.v128_const('f32x4', case_data[1][1]),
                                                                            self.v128_const('i32', idx_func),
                                                                            '  '+self.v128_const('f32', ret)+'\n'))

            case_cnt += 1
            if case_cnt == 2:
                case_cnt = 0

        lst_diff_lane_vs_clause_assert.append('')

        # Add test for operations with constant operands
        for key in lst_oprt_with_const_assert:

            case_cnt = 0
            for case_data in lst_oprt_with_const_assert[key]:

                # Add comment for the param combination
                if case_cnt == 0:
                    template.append(';; {} const vs const'.format(op_name))
                if case_cnt == 4:
                    template.append(';; {} param vs const'.format(op_name))

                # Cross parameters and constants
                if case_cnt < 4:
                    template.append(str(AssertReturn(case_data[0], [], self.v128_const('f32x4', case_data[1]))))
                else:
                    template.append(str(AssertReturn(case_data[0], [self.v128_const('f32x4', case_data[1])], self.v128_const('f32x4', case_data[2]))))
                case_cnt += 1

        # Generate and append f32x4.abs assert
        op_name = self.full_op_name('abs')
        func_name = "{}_with_const".format(op_name)
        template.append('')
        template.append(str(AssertReturn(func_name, [], self.v128_const('f32x4', ['0', '1', '2', '3']))))

        template.extend(lst_diff_lane_vs_clause_assert)

        return template

    @property
    def combine_ternary_arith_test_data(self):
        return {
            'min-max': [
                ['1.125'] * 4, ['0.25'] * 4, ['0.125'] * 4, ['0.125'] * 4
            ],
            'max-min': [
                ['1.125'] * 4, ['0.25'] * 4, ['0.125'] * 4, ['0.25'] * 4
            ]
        }

    @property
    def combine_binary_arith_test_data(self):
        return {
            'min-abs': [
                ['-1.125'] * 4, ['0.125'] * 4, ['0.125'] * 4
            ],
            'max-abs': [
                ['-1.125'] * 4, ['0.125'] * 4, ['1.125'] * 4
            ]
        }

    def get_normal_case(self):
        """Normal test cases from WebAssembly core tests, 4 assert statements:
            assert_return
            assert_return_canonical_nan
            assert_return_arithmetic_nan
            assert_malformed
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

        # Test opposite signs of zero
        lst_oppo_signs_0 = [
            '\n;; Test opposite signs of zero',
            [
                'f32x4.min',
                [['0', '0', '-0', '+0'], ['+0', '-0', '+0', '-0']],
                [['0', '-0', '-0', '-0']],
                ['f32x4', 'f32x4', 'f32x4']
            ],
            [
                'f32x4.min',
                [['-0', '-0', '-0', '-0'], ['+0', '+0', '+0', '+0']],
                [['-0', '-0', '-0', '-0']],
                ['f32x4', 'f32x4', 'f32x4']
            ],
            [
                'f32x4.max',
                [['0', '0', '-0', '+0'], ['+0', '-0', '+0', '-0']],
                [['0', '0', '0', '0']],
                ['f32x4', 'f32x4', 'f32x4']
            ],
            [
                'f32x4.max',
                [['-0', '-0', '-0', '-0'], ['+0', '+0', '+0', '+0']],
                [['+0', '+0', '+0', '+0']],
                ['f32x4', 'f32x4', 'f32x4']
            ],
            '\n'
        ]

        # Generate test case for opposite signs of zero
        for case_data in lst_oppo_signs_0:

            if isinstance(case_data, str):
                cases.append(case_data)
                continue

            cases.append(str(AssertReturn(case_data[0],
                                          [self.v128_const(case_data[3][0], case_data[1][0]),
                                           self.v128_const(case_data[3][1], case_data[1][1])],
                                          self.v128_const(case_data[3][2], case_data[2][0]))))

        for p in self.FLOAT_NUMBERS:
            op_name = self.full_op_name('abs')
            result = unary_op('abs', p)
            # Abs operation is valid for all the floating point numbers
            unary_test_data.append(['assert_return', op_name, p, result])

        for case in unary_test_data:
            cases.append(self.single_unary_test(case))

        self.get_unknown_operator_case(cases)

        return '\n'.join(cases)

    def get_unknown_operator_case(self, cases):
        """Unknown operator cases.
        """

        tpl_assert = "(assert_malformed (module quote \"(memory 1) (func (result v128) " \
                     "({}.{} {}))\") \"unknown operator\")"

        unknown_op_cases = ['\n\n;; Unknown operators\n']
        cases.extend(unknown_op_cases)

        for lane_type in ['i8x16', 'i16x8', 'i32x4']:

            for op in self.UNARY_OPS:
                cases.append(tpl_assert.format(lane_type, op, self.v128_const('i32x4', '0')))

            for op in self.BINARY_OPS:
                cases.append(tpl_assert.format(lane_type, op, ' '.join([self.v128_const('i32x4', '0')]*2)))

    def gen_test_cases(self):
        wast_filename = '../simd_{lane_type}.wast'.format(lane_type=self.LANE_TYPE)
        with open(wast_filename, 'w') as fp:
            txt_test_case = self.get_all_cases()
            txt_test_case = txt_test_case.replace('f32x4 arithmetic', 'f32x4 [abs, min, max]')
            fp.write(txt_test_case)


def gen_test_cases():
    simd_f32x4_case = Simdf32x4Case()
    simd_f32x4_case.gen_test_cases()


if __name__ == '__main__':
    gen_test_cases()
