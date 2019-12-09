#!/usr/bin/env python3

"""
Generate f32x4 floating-point arithmetic operation cases.
"""

from simd_f32x4_arith import Simdf32x4ArithmeticCase
from simd_float_op import FloatingPointArithOp


class F64ArithOp(FloatingPointArithOp):
    maximum = '0x1.fffffffffffffp+1023'


class Simdf64x2ArithmeticCase(Simdf32x4ArithmeticCase):

    LANE_LEN = 2
    LANE_TYPE = 'f64x2'

    floatOp = F64ArithOp()

    FLOAT_NUMBERS = (
        '0x0p+0', '-0x0p+0', '0x1p-1022', '-0x1p-1022', '0x1p-1', '-0x1p-1', '0x1p+0', '-0x1p+0',
        '0x1.921fb54442d18p+2', '-0x1.921fb54442d18p+2', '0x1.fffffffffffffp+1023', '-0x1.fffffffffffffp+1023',
        '0x0.0000000000001p-1022', '0x0.0000000000001p-1022', 'inf', '-inf'
    )
    LITERAL_NUMBERS = ('0123456789', '0123456789e019', '0123456789e+019', '0123456789e-019',
                       '0123456789.', '0123456789.e019', '0123456789.e+019', '0123456789.e-019',
                       '0123456789.0123456789', '0123456789.0123456789e019',
                       '0123456789.0123456789e+019', '0123456789.0123456789e-019',
                       '0x0123456789ABCDEFabcdef', '0x0123456789ABCDEFabcdefp019',
                       '0x0123456789ABCDEFabcdefp+019', '0x0123456789ABCDEFabcdefp-019',
                       '0x0123456789ABCDEFabcdef.', '0x0123456789ABCDEFabcdef.p019',
                       '0x0123456789ABCDEFabcdef.p+019', '0x0123456789ABCDEFabcdef.p-019',
                       '0x0123456789ABCDEFabcdef.0123456789ABCDEFabcdef',
                       '0x0123456789ABCDEFabcdef.0123456789ABCDEFabcdefp019',
                       '0x0123456789ABCDEFabcdef.0123456789ABCDEFabcdefp+019',
                       '0x0123456789ABCDEFabcdef.0123456789ABCDEFabcdefp-019'
    )
    NAN_NUMBERS = ('nan', '-nan', 'nan:0x4000000000000', '-nan:0x4000000000000')

    @staticmethod
    def v128_const(lane, value):
        return '(v128.const {lane_type} {value})'.format(lane_type=lane, value=' '.join([str(value)] * 2))

    @property
    def combine_ternary_arith_test_data(self):
        return {
            'add-sub': [
                ['1.125'] * 2, ['0.25'] * 2, ['0.125'] * 2, ['1.0'] * 2
            ],
            'sub-add': [
                ['1.125'] * 2, ['0.25'] * 2, ['0.125'] * 2, ['1.25'] * 2
            ],
            'mul-add': [
                ['1.25'] * 2, ['0.25'] * 2, ['0.25'] * 2, ['0.375'] * 2
            ],
            'mul-sub': [
                ['1.125'] * 2, ['0.125'] * 2, ['0.25'] * 2, ['0.25'] * 2
            ],
            'div-add': [
                ['1.125'] * 2, ['0.125'] * 2, ['0.25'] * 2, ['5.0'] * 2
            ],
            'div-sub': [
                ['1.125'] * 2, ['0.125'] * 2, ['0.25'] * 2, ['4.0'] * 2
            ],
            'mul-div': [
                ['1.125'] * 2, ['0.125'] * 2, ['0.25'] * 2, ['2.25'] * 2
            ],
            'div-mul': [
                ['1.125'] * 2, ['4'] * 2, ['0.25'] * 2, ['18.0'] * 2
            ]
        }

    @property
    def combine_binary_arith_test_data(self):
        return {
            'add-neg': [
                ['1.125'] * 2, ['0.125'] * 2, ['-1.0'] * 2
            ],
            'sub-neg': [
                ['1.125'] * 2, ['0.125'] * 2, ['-1.25'] * 2
            ],
            'mul-neg': [
                ['1.5'] * 2, ['0.25'] * 2, ['-0.375'] * 2
            ],
            'div-neg': [
                ['1.5'] * 2, ['0.25'] * 2, ['-6'] * 2
            ],
            'add-sqrt': [
                ['2.25'] * 2, ['0.25'] * 2, ['1.75'] * 2
            ],
            'sub-sqrt': [
                ['2.25'] * 2, ['0.25'] * 2, ['1.25'] * 2
            ],
            'mul-sqrt': [
                ['2.25'] * 2, ['0.25'] * 2, ['0.375'] * 2
            ],
            'div-sqrt': [
                ['2.25'] * 2, ['0.25'] * 2, ['6'] * 2
            ]
        }

    def get_normal_case(self):
        return super().get_normal_case().replace('nan_f32x4', 'nan_f64x2')

    def get_invalid_cases(self):
        return super().get_invalid_cases().replace('32', '64')

    @property
    def mixed_sqrt_nan_test_data(self):
        return {
            'neg': [
                ['nan', '1.0', 'nan', '-1.0'],
            ],
            'sqrt': [
                ['4.0', '-nan', '2.0', 'nan'],
            ],
            'add': [
                ['nan 1.0', '-1.0 1.0', 'nan', '2.0'],
            ],
            'sub': [
                ['1.0 -1.0', '-nan 1.0', 'nan', '-2.0'],
            ],
            'mul': [
                ['1.0 2.0', 'nan 2.0', 'nan', '4.0'],
            ],
            'div': [
                ['6.0 nan', '3.0 -nan', '2.0', 'nan']
            ]
        }

    def mixed_nan_test(self, cases):
        """Mask the mixed nan tests of simd_f32x4_arith as we'll use
        call_indirect."""
        test_data_lines = [
            '\n;; Mixed f64x2 tests when some lanes are NaNs',
            '(module',
            '  (type $v_v (func (param v128) (result v128)))',
            '  (type $vv_v (func (param v128 v128) (result v128)))',
            '  (table funcref (elem {}))\n'.format(
                ' '.join(['$64x2_' + op for op in self.UNARY_OPS + self.BINARY_OPS]))

        ]
        for op in self.UNARY_OPS:
            test_data_lines.append(
                '  (func $64x2_{op} (type $v_v) (f64x2.{op} (local.get 0)))'.format(op=op)
            )
        for op in self.BINARY_OPS:
            test_data_lines.append(
                '  (func $64x2_{op} (type $vv_v) (f64x2.{op} (local.get 0) (local.get 1)))'.format(op=op)
            )
        test_data_lines.append('')
        for index in range(2):
            test_data_lines.extend([
                '  (func (export "call_indirect_v_v_f64x2_extract_lane_{i}")'.format(i=index),
                '    (param v128 i32) (result f64)',
                '      (f64x2.extract_lane {i}'.format(i=index),
                '        (call_indirect (type $v_v) (local.get 0) (local.get 1))))'])
            test_data_lines.extend([
                '  (func (export "call_indirect_vv_v_f64x2_extract_lane_{i}")'.format(i=index),
                '    (param v128 v128 i32) (result f64)',
                '      (f64x2.extract_lane {i}'.format(i=index),
                '        (call_indirect (type $vv_v) (local.get 0) (local.get 1) (local.get 2))))'])

        test_data_lines.append(')')

        for index, op in enumerate(self.UNARY_OPS):
            data_set = self.mixed_sqrt_nan_test_data.get(op)
            for data in data_set:
                for i in range(2):
                    if 'nan' in data[i + 2]:
                        test_data_lines.append(''.join([
                            '(assert_return_canonical_nan ',
                            '(invoke "call_indirect_v_v_f64x2_extract_lane_{i}" '.format(i=i),
                            '(v128.const f64x2 {p}) (i32.const {index})))'.format(
                                p=' '.join(data[:2]), index=index)
                        ]))
                    else:
                        test_data_lines.append(''.join([
                            '(assert_return ',
                            '(invoke "call_indirect_v_v_f64x2_extract_lane_{i}" '.format(i=i),
                            '(v128.const f64x2 {p}) (i32.const {index})) (f64.const {r}))'.format(
                                p=' '.join(data[:2]), index=index, r=data[i + 2])
                        ]))

        for index, op in enumerate(self.BINARY_OPS, start=2):
            data_set = self.mixed_sqrt_nan_test_data.get(op)
            for data in data_set:
                for i in range(2):
                    if 'nan' in data[i + 2]:
                        test_data_lines.append(''.join([
                            '(assert_return_canonical_nan ',
                            '(invoke "call_indirect_vv_v_f64x2_extract_lane_{i}" '.format(i=i),
                            '(v128.const f64x2 {p1}) (v128.const f64x2 {p2}) (i32.const {index})))'.format(
                                p1=data[0], p2=data[1], index=index)
                        ]))
                    else:
                        test_data_lines.append(''.join([
                            '(assert_return ',
                            '(invoke "call_indirect_vv_v_f64x2_extract_lane_{i}" '.format(i=i),
                            '(v128.const f64x2 {p1}) (v128.const f64x2 {p2}) (i32.const {index})) '.format(
                                p1=data[0], p2=data[1], index=index),
                            ' (f64.const {r}))'.format(r=data[i + 2])
                        ]))

        cases.extend(test_data_lines)


def gen_test_cases():
    simd_f64x2_arith = Simdf64x2ArithmeticCase()
    simd_f64x2_arith.gen_test_cases()


if __name__ == '__main__':
    gen_test_cases()