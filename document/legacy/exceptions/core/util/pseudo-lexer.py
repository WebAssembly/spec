from pygments.lexer import RegexLexer
from pygments.token import *
from sphinx.highlighting import lexers

class PseudoLexer(RegexLexer):
  name = 'Pseudo'
  aliases = ['pseudo']
  filenames = ['*.pseudo']

  tokens = {
      'root': [
          (r"(?<![(])\btype\b", Keyword),
          (r"(?<![(])\bvar\b", Keyword),
          (r"\bfunc\b", Keyword),
          (r"(?<![(])\breturn\b", Keyword),
          (r"\blet\b", Keyword),
          (r"\bswitch\b", Keyword),
          (r"\bcase\b", Keyword),
          (r"(?<![(])\bif\b", Keyword),
          (r"\bforeach\b", Keyword),
          (r"\bin\b", Keyword),
          (r"(?<=type[ ])[_a-zA-Z0-9]+", Name.Function),
          (r"(?<=func[ ])[_a-zA-Z0-9]+", Name.Function),
          (r"(?<=var[ ])[_a-zA-Z0-9]+", Name.Function),
          (r"(?<=let[ ])[_a-zA-Z0-9]+", Name.Function),
          (r"[_a-zA-Z0-9]+(?=[ ][:][ ])", Name.Function),
          (r".", Text),
      ]
  }

def setup(app):
  lexers['pseudo'] = PseudoLexer()
