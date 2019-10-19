#!/usr/bin/env python3

"""
This python file is a tool class for SIMD and
currently only supports generating v128 const constant data.
"""


class SIMD(object):

    # Constant template
    CONST = '({}.const {})'

    # v128 Constant template
    V128_CONST = '(v128.const {} {})'

    def const(self, val, lane_type):
        """
        generation constant data, [e.g. i32, i64, f32, f64]
        Params:
            val: constant data, string or list,
            lane_type: lane type, [i32, i64, f32, f64]
        """
        return self.CONST.format(lane_type, ''.join(val))

    def v128_const(self, val, lane_type):
        """
        generation v128 constant data, [e.g. i8x16, i16x8, i32x4, f32x4]
        Params:
            val: constant data, string or list,
            lane_type: lane type, [e.g. i8x16, i16x8, i32x4, f32x4]
        """

        if lane_type.lower().find('x') == -1:
            return self.const(val, lane_type)

        lane_cnt = int(lane_type[1:].split('x')[1])

        # val is a string type, generating constant data
        # of val according to the number of lanes
        if isinstance(val, str):
            data_elem = [val] * lane_cnt

        # If val is type of list, generate constant data
        # according to combination of list contents and number of lanes
        elif isinstance(val, list):

            # If it is an empty list, generate all constant data with 0x00
            if len(val) == 0:
                return self.v128_const('0x00', lane_type)

            data_elem = []

            # Calculate the number of times each element in val is copied
            times = lane_cnt // len(val)

            # Calculate whether the data needs to be filled according to
            # the number of elements in the val list and the number of lanes.
            complement = lane_cnt % len(val)
            complement_item = ''

            # If the number of elements in the val list is greater than the number of lanes,
            # paste data with the number of lanes from the val list.
            if times == 0:
                times = 1
                complement = 0

                val = val[0:lane_cnt]

            # Copy data
            for item in val:
                data_elem.extend([item] * times)
                complement_item = item

            # Fill in the data
            if complement > 0:
                data_elem.extend([complement_item] * complement)

        # Get string
        data_elem = ' '.join(data_elem)

        # Returns v128 constant text
        return self.V128_CONST.format(lane_type, data_elem)