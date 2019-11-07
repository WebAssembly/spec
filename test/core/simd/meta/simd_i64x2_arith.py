#!/usr/bin/env python3

"""
Generate i64x2 integer arithmetic operation cases.
"""

from simd_arithmetic import SimdArithmeticCase


class SimdI64x2ArithmeticCase(SimdArithmeticCase):

    LANE_LEN = 2
    LANE_TYPE = 'i64x2'

    @property
    def hex_binary_op_test_data(self):
        return [
            ('0x3fffffffffffffff', '0x4000000000000000'),
            ('0x4000000000000000', '0x4000000000000000'),
            ('-0x3fffffffffffffff', '-0x40000000fffffff'),
            ('-0x4000000000000000', '-0x400000000000000'),
            ('-0x4000000000000000', '-0x400000000000001'),
            ('0x7fffffffffffffff', '0x7ffffffffffffff'),
            ('0x7fffffffffffffff', '0x01'),
            ('0x8000000000000000', '-0x01'),
            ('0x7fffffffffffffff', '0x8000000000000000'),
            ('0x8000000000000000', '0x8000000000000000'),
            ('0xffffffffffffffff', '0x01'),
            ('0xffffffffffffffff', '0xffffffffffffffff')
        ]

    @property
    def hex_unary_op_test_data(self):
        return ['0x01', '-0x01', '-0x8000000000000000', '-0x7fffffffffffffff',
                '0x7fffffffffffffff', '0x8000000000000000', '0xffffffffffffffff']

    @property
    def i64x2_i8x16_test_data(self):
        """This test data will be intepreted by the SIMD.v128_const() method in simd.py."""
        return {
            'i64x2.add': [
                [['0x7fffffffffffffff', ['0', '0', '0', '0', '0', '0', '0', '0x80'] * 2], '-1',
                 ['i64x2', 'i8x16', 'i64x2']],
                [['1', '255'], '0', ['i64x2', 'i8x16', 'i64x2']]
            ],
            'i64x2.sub': [
                [['0x7fffffffffffffff', ['0', '0', '0', '0', '0', '0', '0', '0x80'] * 2], '-1',
                 ['i64x2', 'i8x16', 'i64x2']],
                [['1', '255'], '2', ['i64x2', 'i8x16', 'i64x2']]
            ],
            'i64x2.mul': [
                [['0x8000000000000000', '0x2'], '0', ['i64x2', 'i8x16', 'i64x2']],
                [['0xffffffffffffffff', '255'], '1', ['i64x2', 'i8x16', 'i64x2']]
            ]
        }

    @property
    def i64x2_i16x8_test_data(self):
        """This test data will be intepreted by the SIMD.v128_const() method in simd.py."""
        return {
            'i64x2.add': [
                [['0x7fffffffffffffff', ['0', '0', '0', '0x8000'] * 2], '-1', ['i64x2', 'i16x8', 'i64x2']],
                [['1', '0xffff'], '0', ['i64x2', 'i16x8', 'i64x2']]
            ],
            'i64x2.sub': [
                [['0x7fffffffffffffff', ['0', '0', '0', '0x8000'] * 2], '-1', ['i64x2', 'i16x8', 'i64x2']],
                [['1', '0xffff'], '2', ['i64x2', 'i16x8', 'i64x2']]
            ],
            'i64x2.mul': [
                [['0x8000000000000000', ['0', '0', '0', '0x02'] * 4], '0', ['i64x2', 'i16x8', 'i64x2']],
                [['0xffffffffffffffff', '0xffff'], '1', ['i64x2', 'i16x8', 'i64x2']]
            ]
        }

    @property
    def i64x2_i32x4_test_data(self):
        """This test data will be intepreted by the SIMD.v128_const() method in simd.py."""
        return {
            'i64x2.add': [
                [['0x7fffffffffffffff', ['0', '0x80000000'] * 2], '-1', ['i64x2', 'i32x4', 'i64x2']],
                [['1', '0xffffffff'], '0', ['i64x2', 'i32x4', 'i64x2']]
            ],
            'i64x2.sub': [
                [['0x7fffffffffffffff', ['0', '0x80000000'] * 2], '-1', ['i64x2', 'i32x4', 'i64x2']],
                [['1', '0xffffffff'], '2', ['i64x2', 'i32x4', 'i64x2']]
            ],
            'i64x2.mul': [
                [['0x8000000000000000', ['0', '0x02'] * 2], '0', ['i64x2', 'i32x4', 'i64x2']],
                [['0xffffffffffffffff', '0xffffffff'], '1', ['i64x2', 'i32x4', 'i64x2']]
            ]
        }

    @property
    def i64x2_f64x2_test_data(self):
        """This test data will be intepreted by the SIMD.v128_const() method in simd.py."""
        return {
            'i64x2.add': [
                [['0x8000000000000000', '+0.0'], '0x8000000000000000', ['i64x2', 'f64x2', 'i64x2']],
                [['0x8000000000000000', '-0.0'], '0', ['i64x2', 'f64x2', 'i64x2']],
                [['0x8000000000000000', '1.0'], '0xbff0000000000000', ['i64x2', 'f64x2', 'i64x2']],
                [['0x8000000000000000', '-1.0'], '0x3ff0000000000000', ['i64x2', 'f64x2', 'i64x2']],
                [['1', '+inf'], '0x7ff0000000000001', ['i64x2', 'f64x2', 'i64x2']],
                [['1', '-inf'], '0xfff0000000000001', ['i64x2', 'f64x2', 'i64x2']],
                [['1', 'nan'], '0x7ff8000000000001', ['i64x2', 'f64x2', 'i64x2']]
            ],
            'i64x2.sub': [
                [['0x8000000000000000', '+0.0'], '0x8000000000000000', ['i64x2', 'f64x2', 'i64x2']],
                [['0x8000000000000000', '-0.0'], '0', ['i64x2', 'f64x2', 'i64x2']],
                [['0x8000000000000000', '1.0'], '0x4010000000000000', ['i64x2', 'f64x2', 'i64x2']],
                [['0x8000000000000000', '-1.0'], '0xc010000000000000', ['i64x2', 'f64x2', 'i64x2']],
                [['0x1', '+inf'], '0x8010000000000001', ['i64x2', 'f64x2', 'i64x2']],
                [['0x1', '-inf'], '0x0010000000000001', ['i64x2', 'f64x2', 'i64x2']],
                [['0x1', 'nan'], '0x8008000000000001', ['i64x2', 'f64x2', 'i64x2']]
            ],
            'i64x2.mul': [
                [['0x80000000', '+0.0'], '0', ['i64x2', 'f64x2', 'i64x2']],
                [['0x80000000', '-0.0'], '0', ['i64x2', 'f64x2', 'i64x2']],
                [['0x80000000', '1.0'], '0', ['i64x2', 'f64x2', 'i64x2']],
                [['0x80000000', '-1.0'], '0', ['i64x2', 'f64x2', 'i64x2']],
                [['0x1', '+inf'], '0x7ff0000000000000', ['i64x2', 'f64x2', 'i64x2']],
                [['0x1', '-inf'], '0xfff0000000000000', ['i64x2', 'f64x2', 'i64x2']],
                [['0x1', 'nan'], '0x7ff8000000000000', ['i64x2', 'f64x2', 'i64x2']]
            ]
        }

    @property
    def combine_dec_hex_test_data(self):
        """This test data will be intepreted by the SIMD.v128_const() method in simd.py."""
        return {
            'i64x2.add': [
                [[['0', '1'], ['0', '0xffffffffffffffff']], ['0'] * 2, ['i64x2'] * 3]
            ],
            'i64x2.sub': [
                [[['0', '1'], ['0', '0xffffffffffffffff']], ['0', '0x02'], ['i64x2'] * 3]
            ],
            'i64x2.mul': [
                [[['0', '1'], ['0', '0xffffffffffffffff']], ['0', '0xffffffffffffffff'], ['i64x2'] * 3]
            ]
        }

    @property
    def range_test_data(self):
        """This test data will be intepreted by the SIMD.v128_const() method in simd.py."""
        return {
            'i64x2.add': [
                [[[str(i) for i in range(2)], [str(i * 2) for i in range(2)]],
                 [str(i * 3) for i in range(2)], ['i64x2'] * 3]
            ],
            'i64x2.sub': [
                [[[str(i) for i in range(2)], [str(i * 2) for i in range(2)]],
                 [str(-i) for i in range(2)], ['i64x2'] * 3]
            ],
            'i64x2.mul': [
                [[[str(i) for i in range(2)], [str(i * 2) for i in range(4)]],
                 ['0', '0x02'], ['i64x2'] * 3]
            ]
        }

    @property
    def full_bin_test_data(self):
        return [
            self.i64x2_i8x16_test_data,
            self.i64x2_i16x8_test_data,
            self.i64x2_i32x4_test_data,
            self.i64x2_f64x2_test_data,
            self.combine_dec_hex_test_data,
            self.range_test_data
        ]


def gen_test_cases():
    simd_i64x2_arith = SimdI64x2ArithmeticCase()
    simd_i64x2_arith.gen_test_cases()


if __name__ == '__main__':
    gen_test_cases()