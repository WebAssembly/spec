#!/usr/bin/env python

class SExp(object):
    def __init__(self, thing, begin=-1, end=-1):
        assert (begin == -1) == (end == -1)
        assert not isinstance(thing, SExp)
        self.thing = thing
        self.begin = begin
        self.end = end

    def __repr__(self):
        return str(self.thing) + ':' + str(self.begin) + ':' + str(self.end)

    def __str__(self):
        return str(self.thing)

    def has_location(self):
        return self.begin != -1

    def is_operator(self, name):
        return isinstance(self.thing, list) and len(self.thing) > 0 and self.thing[0].thing == name

    def num_operands(self):
        return len(self.thing) - 1

    def get_operand(self, index):
        return self.thing[index + 1]

    def strip(self):
        if isinstance(self.thing, list):
            for item in self.thing:
                item.strip()
        self.begin = -1
        self.end = -1

def isspace(c):
    return c == ' ' or c == '\t' or c == '\n' or c == '\r'

def isdigit(c):
    return c >= '0' and c <= '9'

def isalnum(c):
    return isdigit(c) or (c >= 'a' and c <= 'z') or (c >= 'A' and c <= 'Z')

def skip_whitespace_and_comments(s, i):
    l = len(s)
    while i < l:
        if isspace(s[i]):
            i += 1
            # fixme
            #while i < l and isspace(s[i]):
                #i += 1
        elif s[i] == ';' and i+1 < l and s[i+1] == ';':
            i += 2
            while i < l and s[i] != '\n':
                i += 1
        else:
            break
    return i

def parse_string_literal(s, i):
    j = i
    assert s[j] == '"'
    j += 1
    while s[j] != '"':
        if s[j] == '\\':
            j += 1
        j += 1
    assert s[j] == '"'
    j += 1
    return (SExp(s[i:j], i, j), j)

def parse_number_literal(s, i):
    j = i
    while isalnum(s[j]) or s[j] in ['.', '+', '-']:
        j += 1
    t = s[i:j]
    if t.find('.') == -1:
        x = int(t)
    elif t.startswith('0x'):
        x = float(t)
    else:
        x = float(t)
    return (SExp(x, i, j), j)

def parse_atom(s, i):
    if s[i] == '"':
        return parse_string_literal(s, i)
    if isdigit(s[i]) or s[i] == '+' or s[i] == '-' or s[i:4] == 'nan(' or s[i:i+8] == 'infinity':
        return parse_number_literal(s, i)

    j = i
    while not isspace(s[j]) and s[j] != ')':
        j += 1

    return (SExp(s[i:j], i, j), j)

def parse_list(s, i):
    items = []
    j = i
    assert s[j] == '('
    j += 1
    while s[j] != ')':
        (result, j) = parse_at_position(s, j)
        items.append(result)
        j = skip_whitespace_and_comments(s, j)
    assert s[j] == ')'
    j += 1
    return (SExp(items, i, j), j)

def parse_at_position(s, i):
    i = skip_whitespace_and_comments(s, i)
    if s[i] == '(':
        return parse_list(s, i)
    else:
        return parse_atom(s, i)

def parse(s):
    (result, _) = parse_at_position(s, 0)
    return result

def parse_toplevel(s):
    i = 0
    j = i
    items = []
    while j < len(s):
        (result, j) = parse_at_position(s, j)
        items.append(result)
        j = skip_whitespace_and_comments(s, j)
    return SExp(items, i, j)

class IdentityTransform(object):
    def transform_list_preorder(self, sexp):
        return sexp
    def transform_list_postorder(self, sexp):
        return sexp
    def transform_int(self, sexp):
        return sexp
    def transform_float(self, sexp):
        return sexp
    def transform_str(self, sexp):
        return sexp
    def transform_keyword(self, sexp):
        return sexp

def transform(sexp, visitor):
    if isinstance(sexp.thing, list):
        sexp = visitor.transform_list_preorder(sexp)
        new_list = []
        for item in sexp.thing:
            new_item = transform(item, visitor)
            new_list.append(new_item)
        sexp = SExp(new_list, sexp.begin, sexp.end)
        new_sexp = visitor.transform_list_postorder(sexp)
    elif isinstance(sexp.thing, int):
        new_sexp = visitor.transform_int(sexp)
    elif isinstance(sexp.thing, float):
        new_sexp = visitor.transform_float(sexp)
    elif isinstance(sexp.thing, str):
        if sexp.thing[0] == '"':
            new_sexp = visitor.transform_str(sexp)
        else:
            new_sexp = visitor.transform_keyword(sexp)
    else:
        raise "unknown thing to transform"
    if new_sexp != sexp:
        # For convenience, allow the transform to return a sexp without setting
        # the begin/end. Clear out any nodes that it scavenged, and set the
        # outermost position.
        new_sexp.strip()
        new_sexp.begin = sexp.begin
        new_sexp.end = sexp.end
    return new_sexp

class ToStringWithTemplateVisitor(object):
    def __init__(self):
        self.s = ''
        self.current = 0

def to_string_with_template_recursion(sexp, s, visitor, toplevel):
    if sexp.has_location():
        substr = s[visitor.current:sexp.begin]
        visitor.s += substr
        visitor.current += len(substr)
    if isinstance(sexp.thing, list):
        if not toplevel:
            visitor.s += '('
            visitor.current += 1
        for item in sexp.thing:
            to_string_with_template_recursion(item, s, visitor, False)
            if not item.has_location():
                visitor.s += ' '
        if not sexp.thing[-1].has_location():
            visitor.s = visitor.s[:-1]
        if toplevel:
            if sexp.thing[-1].has_location() and sexp.has_location():
                visitor.s += s[visitor.current:sexp.end]
        else:
            if sexp.thing[-1].has_location() and sexp.has_location():
                visitor.s += s[visitor.current:(sexp.end - 1)]
            visitor.s += ')'
            visitor.current += 1
    elif isinstance(sexp.thing, int):
        visitor.s += str(sexp.thing)
    elif isinstance(sexp.thing, float):
        visitor.s += str(sexp.thing)
    elif isinstance(sexp.thing, str):
        visitor.s += sexp.thing
    else:
        raise "unknown thing"
    if sexp.has_location():
        visitor.current = sexp.end

def to_string_with_template(sexp, s):
    """Convert the given s-expression to a string.

    This function takes an extra string argument which is the original string
    from which the given s-expression was parsed, and to which its begin and
    end indices refer. Whitespace and comments from the original string are
    preserved in the resulting string whenever possible.
    """
    visitor = ToStringWithTemplateVisitor()
    to_string_with_template_recursion(sexp, s, visitor, False)
    return visitor.s

def toplevel_to_string_with_template(sexp, s):
    """Convert the given toplevel s-expression to a string.

    This function is like to_string_with_template except that it specially
    formats toplevel lists which are not enclosed by explicit parens.
    """
    visitor = ToStringWithTemplateVisitor()
    to_string_with_template_recursion(sexp, s, visitor, True)
    return visitor.s
