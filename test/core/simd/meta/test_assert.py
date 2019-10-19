#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
This python file is a tool class for test generation.
Currently only the 'AssertReturn' class that is used
to generate the 'assert_return' assertion.
TODO: Add more assertions
"""


# Generate assert_return to test
class AssertReturn:

    instruction = ''
    instruction_param = ''
    expected_result = ''

    def __init__(self, instruction, instruction_param, expected_result):
        super(AssertReturn, self).__init__()

        # Convert to list if got str
        if isinstance(instruction_param, str):
            instruction_param = [instruction_param]
        if isinstance(expected_result, str):
            expected_result = [expected_result]

        self.instruction = instruction
        self.instruction_param = instruction_param
        self.expected_result = expected_result

    def __str__(self):
        assert_return = '(assert_return (invoke "{}"'.format(self.instruction)

        head_len = len(assert_return)

        # Add write space to make the test case easier to read
        params = []
        for param in self.instruction_param:
            white_space = ' '
            if len(params) != 0:
                white_space = '\n ' + ' ' * head_len
            params.append(white_space + param)

        results = []
        for result in self.expected_result:
            white_space = ' '
            if len(params) != 0 or len(results) != 0:
                white_space = '\n ' + ' ' * head_len
            results.append(white_space + result)

        return '{}{}){})'.format(assert_return, ''.join(params), ''.join(results))