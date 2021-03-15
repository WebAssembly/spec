from sphinx.directives.patches import MathDirective
from sphinx.util.texescape import tex_replace_map
from sphinx.writers.html5 import HTML5Translator
from sphinx.writers.latex import LaTeXTranslator
from docutils import nodes
from docutils.nodes import math
from docutils.parsers.rst.directives.misc import Replace
from six import text_type
import re


# Transform \xref in math nodes

xref_re = re.compile('\\\\xref\{([^}]*)\}\{([^}]*)\}', re.M)

def html_hyperlink(file, id):
  return '\\href{../%s.html#%s}' % (file, id.replace('_', '-'))

def html_transform_math_xref(node):
  new_text = xref_re.sub(lambda m: html_hyperlink(m.group(1), m.group(2)), node.astext())
  node.children[0] = nodes.Text(new_text)

# Mirrors sphinx/writers/latex
def latex_hyperlink(file, id):
  id = text_type(id).translate(tex_replace_map).\
    encode('ascii', 'backslashreplace').decode('ascii').\
    replace('_', '-').replace('\\', '_')
  return '\\hyperref[%s:%s]' % (file, id)

def latex_transform_math_xref(node):
  new_text = xref_re.sub(lambda m: latex_hyperlink(m.group(1), m.group(2)), node.astext())
  node.children[0] = nodes.Text(new_text)

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
  return [math(raw, text)], []

class ExtMathDirective(MathDirective):
  def run(self):
    doc = self.state.document
    for i, s in enumerate(self.content):
      self.content[i] = replace_mathdefs(doc, s)
    for i, s in enumerate(self.arguments):
      self.arguments[i] = replace_mathdefs(doc, s)
    return super().run()

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
    # TODO: we don't ever hit the case where len(self.content) > 1
    for i, s in enumerate(self.content):
      self.content[i] = replace_mathdefs(doc, s)
    doc.mathdefs[name] = [arity, ''.join(self.content)]
    self.content[0] = ':math:`' + self.content[0]
    self.content[-1] = self.content[-1] + '`'
    return super().run()

class WebAssemblyHTML5Translator(HTML5Translator):
  """
  Customize HTML5Translator.
  Convert xref in math and math block nodes to hrefs.
  """
  def visit_math(self, node, math_env = ''):
    html_transform_math_xref(node)
    super().visit_math(node, math_env)

  def visit_math_block(self, node, math_env  = ''):
    html_transform_math_xref(node)
    super().visit_math_block(node, math_env)

class WebAssemblyLaTeXTranslator(LaTeXTranslator):
  """
  Customize LaTeXTranslator.
  Convert xref in math and math block nodes to hyperrefs.
  """
  def visit_math(self, node):
    latex_transform_math_xref(node)
    super().visit_math(node)

  def visit_math_block(self, node):
    latex_transform_math_xref(node)
    super().visit_math_block(node)

# Setup

def setup(app):
  app.set_translator('html', WebAssemblyHTML5Translator)
  app.set_translator('latex', WebAssemblyLaTeXTranslator)
  app.add_role('math', ext_math_role)
  app.add_directive('math', ExtMathDirective, override = True)
  app.add_directive('mathdef', MathdefDirective)
