#!/usr/bin/env python3

from simd_compare import SimdCmpCase


# Generate i64x2 test case
class Simdi64x2CmpCase(SimdCmpCase):
    LANE_TYPE = 'i64x2'

    BINARY_OPS = ['eq', 'ne']

    # Override this since i64x2 does not support as many comparison instructions.
    CASE_TXT = """
;; Test all the {lane_type} comparison operators on major boundary values and all special values.

(module
  (func (export "eq") (param $x v128) (param $y v128) (result v128) ({lane_type}.eq (local.get $x) (local.get $y)))
  (func (export "ne") (param $x v128) (param $y v128) (result v128) ({lane_type}.ne (local.get $x) (local.get $y)))
)

{normal_case}

;; Type check

(assert_invalid (module (func (result v128) ({lane_type}.eq (i32.const 0) (f32.const 0)))) "type mismatch")
(assert_invalid (module (func (result v128) ({lane_type}.ne (i32.const 0) (f32.const 0)))) "type mismatch")
"""

    def get_case_data(self):
        forms = ['i64x2'] * 3
        case_data = []

        case_data.append(['#', 'eq'])
        case_data.append(['#', 'i64x2.eq  (i64x2) (i64x2)'])
        case_data.append(['eq', ['0xFFFFFFFFFFFFFFFF', '0xFFFFFFFFFFFFFFFF'], '-1', forms])
        case_data.append(['eq', ['0x0000000000000000', '0x0000000000000000'], '-1', forms])
        case_data.append(['eq', ['0xF0F0F0F0F0F0F0F0', '0xF0F0F0F0F0F0F0F0'], '-1', forms])
        case_data.append(['eq', ['0x0F0F0F0F0F0F0F0F', '0x0F0F0F0F0F0F0F0F'], '-1', forms])
        case_data.append(['eq', [['0xFFFFFFFFFFFFFFFF', '0x0000000000000000'], ['0xFFFFFFFFFFFFFFFF', '0x0000000000000000']], '-1', forms])
        case_data.append(['eq', [['0x0000000000000000', '0xFFFFFFFFFFFFFFFF'], ['0x0000000000000000', '0xFFFFFFFFFFFFFFFF']], '-1', forms])
        case_data.append(['eq', [['0x03020100', '0x11100904', '0x1A0B0A12', '0xFFABAA1B'],
                          ['0x03020100', '0x11100904', '0x1A0B0A12', '0xFFABAA1B']], '-1', forms])
        case_data.append(['eq', ['0xFFFFFFFFFFFFFFFF', '0x0FFFFFFFFFFFFFFF'], '0', forms])
        case_data.append(['eq', ['0x1', '0x2'], '0', forms])

        case_data.append(['#', 'ne'])
        case_data.append(['#', 'i64x2.ne  (i64x2) (i64x2)'])

        # hex vs hex
        case_data.append(['#', 'hex vs hex'])
        case_data.append(['ne', ['0xFFFFFFFFFFFFFFFF', '0xFFFFFFFFFFFFFFFF'], '0', forms])
        case_data.append(['ne', ['0x0000000000000000', '0x0000000000000000'], '0', forms])
        case_data.append(['ne', ['0xF0F0F0F0F0F0F0F0', '0xF0F0F0F0F0F0F0F0'], '0', forms])
        case_data.append(['ne', ['0x0F0F0F0F0F0F0F0F', '0x0F0F0F0F0F0F0F0F'], '0', forms])
        case_data.append(['ne', [['0xFFFFFFFFFFFFFFFF', '0x0000000000000000'], ['0xFFFFFFFFFFFFFFFF', '0x0000000000000000']], '0', forms])
        case_data.append(['ne', [['0x0000000000000000', '0xFFFFFFFFFFFFFFFF'], ['0x0000000000000000', '0xFFFFFFFFFFFFFFFF']], '0', forms])
        case_data.append(['ne', [['0x03020100', '0x11100904', '0x1A0B0A12', '0xFFABAA1B'],
                          ['0x03020100', '0x11100904', '0x1A0B0A12', '0xFFABAA1B']], '0', forms])

        return case_data


def gen_test_cases():
    i64x2 = Simdi64x2CmpCase()
    i64x2.gen_test_cases()


if __name__ == '__main__':
    i64x2 = Simdi64x2CmpCase()
    i64x2.gen_test_cases()
