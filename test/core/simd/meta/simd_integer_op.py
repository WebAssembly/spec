#!/usr/bin/env python3

"""Common integer value operations"""

from simd_lane_value import LaneValue


class IntegerSimpleOp:
    """Common integer simple ops:
        min_s, min_u, max_s, max_u, avgr_u, abs
    """

    @staticmethod
    def unary_op(op: str, p: str, lane_width: int) -> str:
        """Unary operation on p with the operation specified by op

        :param op: abs
        :param p: a hex or decimal integer literal string
        :lane_width: bit number of each lane in SIMD v128
        :return:
        """
        if '0x' in p:
            base = 16
        else:
            base = 10
        v = int(p, base)

        if op == 'abs':
            result = IntegerSimpleOp.get_valid_value(v, lane_width)
            if result >= 0:
                return p
            else:
                if base == 16:
                    return hex(-result)
                else:
                    return str(-result)
        else:
            raise Exception('Unknown unary operation')

    def binary_op(op: str, p1: str, p2: str, lane_width: int) -> str:
        """Binary operation on p1 and p2 with the operation specified by op

        :param op: min_s, min_u, max_s, max_u, avgr_u
        :param p1: a hex or decimal integer literal string
        :param p2: a hex or decimal integer literal string
        :lane_width: bit number of each lane in SIMD v128
        :return:
        """
        if '0x' in p1:
            base1 = 16
        else:
            base1 = 10
        v1 = int(p1, base1)

        if '0x' in p2:
            base2 = 16
        else:
            base2 = 10
        v2 = int(p2, base2)

        if op in ['min_s', 'max_s']:
            i1 = IntegerSimpleOp.get_valid_value(v1, lane_width)
            i2 = IntegerSimpleOp.get_valid_value(v2, lane_width)
            if op == 'min_s':
                return p1 if i1 <= i2 else p2
            else:
                return p1 if i1 >= i2 else p2

        elif op in ['min_u', 'max_u']:
            i1 = IntegerSimpleOp.get_valid_value(v1, lane_width, signed=False)
            i2 = IntegerSimpleOp.get_valid_value(v2, lane_width, signed=False)
            if op == 'min_u':
                return p1 if i1 <= i2 else p2
            else:
                return p1 if i1 >= i2 else p2

        elif op == 'avgr_u':
            i1 = IntegerSimpleOp.get_valid_value(v1, lane_width, signed=False)
            i2 = IntegerSimpleOp.get_valid_value(v2, lane_width, signed=False)
            result = (i1 + i2 + 1) // 2
            if base1 == 16 or base2 == 16:
                return hex(result)
            else:
                return str(result)

        else:
            raise Exception('Unknown binary operation')

    @staticmethod
    def get_valid_value(value, lane_width, signed=True):
        """Get the valid integer value of value in the specified lane size.
        """
        lane = LaneValue(lane_width)
        value &= lane.mask

        if signed:
            if value > lane.max:
                return value - lane.mod
            if value < lane.min:
                return value + lane.mod

        return value