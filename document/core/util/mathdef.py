from sphinx.ext.mathbase import math
from sphinx.ext.mathbase import displaymath
from sphinx.ext.mathbase import math_role
from sphinx.ext.mathbase import MathDirective
from sphinx.ext.mathbase import latex_visit_math
from sphinx.ext.mathbase import latex_visit_displaymath
from sphinx.ext.mathjax import html_visit_math
from sphinx.ext.mathjax import html_visit_displaymath
from sphinx.util.texescape import tex_escape_map, tex_replace_map
from docutils.parsers.rst.directives.misc import Replace
from six import text_type
import re


# Transform \xref in math nodes

xref_re = re.compile('\\\\xref\{([^}]*)\}\{([^}]*)\}', re.M)

def html_hyperlink(file, id):
  return '\\href{../%s.html#%s}' % (file, id.replace('_', '-'))

def html_transform_math_xref(node):
  node['latex'] = \
    xref_re.sub(lambda m: html_hyperlink(m.group(1), m.group(2)), node['latex'])

def ext_html_visit_math(self, node):
  html_transform_math_xref(node)
  html_visit_math(self, node)

def ext_html_visit_displaymath(self, node):
  html_transform_math_xref(node)
  html_visit_displaymath(self, node)

# Mirrors sphinx/writers/latex
def latex_hyperlink(file, id):
  id = text_type(id).translate(tex_replace_map).\
    encode('ascii', 'backslashreplace').decode('ascii').\
    replace('_', '-').replace('\\', '_')
  return '\\hyperref[%s:%s]' % (file, id)

def latex_transform_math_xref(node):
  node['latex'] = \
    xref_re.sub(lambda m: latex_hyperlink(m.group(1), m.group(2)), node['latex'])

def ext_latex_visit_math(self, node):
  latex_transform_math_xref(node)
  latex_visit_math(self, node)

def ext_latex_visit_displaymath(self, node):
  latex_transform_math_xref(node)
  latex_visit_displaymath(self, node)


# Expand mathdef names in math roles and directives

def_re = re.compile('\\\\[A-Za-z][0-9A-Za-z]*', re.M)

auxcounter = 0

def lookup_mathdef(defs, name):
  if name in defs:
    [arity, s] = defs[name]
    if arity > 0:
      global auxcounter
      auxcounter = auxcounter + 1
      name = "\\mathdef%d" % auxcounter
      s = "\\def%s#%d{%s}%s" % (name, arity, s, name)
    return s
  return name

def replace_mathdefs(doc, s):
  if not hasattr(doc, 'mathdefs'):
    return s
  return def_re.sub(lambda m: lookup_mathdef(doc.mathdefs, m.group(0)), s)

def ext_math_role(role, raw, text, line, inliner, options = {}, content = []):
  text = replace_mathdefs(inliner.document, raw.split('`')[1])
  return math_role(role, raw, text, line, inliner, options = options,
                   content = content)

class ExtMathDirective(MathDirective):
  def run(self):
    doc = self.state.document
    for i, s in enumerate(self.content):
      self.content[i] = replace_mathdefs(doc, s)
    for i, s in enumerate(self.arguments):
      self.arguments[i] = replace_mathdefs(doc, s)
    return super(ExtMathDirective, self).run()

class MathdefDirective(Replace):
  def run(self):
    name = '\\' + self.state.parent.rawsource.split('|')[1]
    name = name.split('#')
    if len(name) > 1:
      arity = int(name[1])
    else:
      arity = 0
    name = name[0]
    doc = self.state.document
    if not hasattr(doc, 'mathdefs'):
      doc.mathdefs = {}
    for i, s in enumerate(self.content):
      self.content[i] = replace_mathdefs(doc, s)
    doc.mathdefs[name] = [arity, ''.join(self.content)]
    self.content[0] = ':math:`' + self.content[0]
    self.content[-1] = self.content[-1] + '`'
    return super(MathdefDirective, self).run()


# Setup

def setup(app):
  app.add_node(math,
               html = (ext_html_visit_math, None),
               latex = (ext_latex_visit_math, None))
  app.add_node(displaymath,
               html = (ext_html_visit_displaymath, None),
               latex = (ext_latex_visit_displaymath, None))
  app.add_role('math', ext_math_role)
  app.add_directive('math', ExtMathDirective)
  app.add_directive('mathdef', MathdefDirective)
