"""Sphinx extension provide a new directive *mathmacro*.

This extension has to be added after the other math extension since it
redefined the math directive and the math role. For example, like this
(in the conf.py file)::

  extensions = [
      'sphinx.ext.autodoc', 'sphinx.ext.doctest',
      'sphinx.ext.mathjax',
      'sphinx.ext.viewcode', 'sphinx.ext.autosummary',
      'numpydoc',
      'mathmacro']

From https://bitbucket.org/fluiddyn/fluiddyn/src/doc/mathmacro.py

"""

from __future__ import print_function

import re

from docutils.parsers.rst.directives.misc import Replace

from sphinx.ext.mathbase import MathDirective
from sphinx.ext.mathbase import math_role


def multiple_replacer(replace_dict):
    """Return a function replacing doing multiple replacements.

    The produced function replace `replace_dict.keys()` by
    `replace_dict.values`, respectively.

    """
    def replacement_function(match):
        s = match.group(0)
        end = s[-1]
        if re.match(r'[\W_]', end):
            return replace_dict[s[:-1]]+end
        else:
            return replace_dict[s]

    pattern = "|".join([re.escape(k)+r'[\W_]'
                        for k in replace_dict.keys()])
    pattern = re.compile(pattern, re.M)
    return lambda string: pattern.sub(replacement_function, string)

def multiple_replace(string, replace_dict):
    mreplace = multiple_replacer(replace_dict)
    return mreplace(string)


class MathMacro(Replace):
    """Directive defining a math macro."""
    def run(self):
        if not hasattr(self.state.document, 'math_macros'):
            self.state.document.math_macros = {}

        latex_key = '\\'+self.state.parent.rawsource.split('|')[1]
        self.state.document.math_macros[latex_key] = ''.join(self.content)

        self.content[0] = ':math:`'+self.content[0]
        self.content[-1] = self.content[-1]+'`'

        return super(MathMacro, self).run()


class NewMathDirective(MathDirective):
    """New math block directive parsing the latex code."""
    def run(self):
        try:
            math_macros = self.state.document.math_macros
        except AttributeError:
            pass
        else:
            if math_macros:
                multiple_replace = multiple_replacer(math_macros)
                for i, c in enumerate(self.content):
                    self.content[i] = multiple_replace(c)
                for i, a in enumerate(self.arguments):
                    self.arguments[i] = multiple_replace(a)
        return super(NewMathDirective, self).run()


def new_math_role(role, rawtext, text, lineno, inliner,
                  options={}, content=[]):
    """New math role parsing the latex code."""
    try:
        math_macros = inliner.document.math_macros
    except AttributeError:
        pass
    else:
        if math_macros:
            rawtext = multiple_replace(rawtext, math_macros)
            text = rawtext.split('`')[1]

    return math_role(role, rawtext, text, lineno, inliner,
                     options=options, content=content)


def setup(app):
    app.add_role('math', new_math_role)
    app.add_directive('math', NewMathDirective)
    app.add_directive('mathmacro', MathMacro)
