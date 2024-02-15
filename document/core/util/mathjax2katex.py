#! /usr/bin/env python3
# -*- coding: latin-1 -*-

import queue
import multiprocessing
import os
import re
import shelve
import subprocess
import sys
import threading


SCRIPT_DIR = os.path.dirname(os.path.realpath(__file__))
# Update this to invalidate the cache; e.g. when updating katex.
CACHE_VERSION = 2


def FindMatching(data, prefix):
  start = data.find(prefix)
  if start < 0:
    return (None, None)
  end = start + 1
  total = 0
  while True:
    if data[end] == '{':
      total += 1
    elif data[end] == '}':
      total -= 1
      if total == 0:
        end += 1
        break
    end += 1
  return (start, end)


def HasBalancedTags(s):
  tt = re.findall(r'(</?\w+|/>)', s)
  tags = []
  for tag in tt:
    if tag == '/>':
      # self-closing tag.
      tags.pop
    elif tag[0] == '</':
      # closing tag
      tag = tag[2:]
      if len(tags) == 0 or tag != tags[-1]:
        expected = '"%s"' % tags[-1] if len(tags) else 'empty tag stack'
        sys.stderr.write('expected %s, got "%s"\n' % (expected, tag))
        sys.stderr.write('tags: %s\n' % tt)
        sys.stderr.write('tag stack: %s\n' % tags)
        sys.stderr.write('string: %s\n' % s)
        return False

      tags.pop()
    else:
      # opening tag
      tags.append(tag[1:])
  return True


def ReplaceMath(cache, data):
  old = data
  data = data.replace('\\\\', '\\DOUBLESLASH')
  data = data.replace('\\(', '')
  data = data.replace('\\)', '')
  data = data.replace('\\[', '')
  data = data.replace('\\]', '')
  data = data.replace('\\DOUBLESLASH', '\\\\')
  data = data.replace('’', '\\text{’}')
  data = data.replace('‘', '\\text{‘}')
  data = data.replace('\\hfill', '')
  data = data.replace('\\mbox', '\\text')
  data = data.replace('\\begin{split}', '\\begin{aligned}')
  data = data.replace('\\end{split}', '\\end{aligned}')
  data = data.replace('&amp;', '&')
  data = data.replace('&lt;', '<')
  data = data.replace('&gt;', '>')
  data = data.replace('{array}[t]', '{array}')
  data = data.replace('{array}[b]', '{array}')
  data = data.replace('@{~}', '')
  data = data.replace('@{}', '')
  data = data.replace('@{\\qquad}', '')
  data = data.replace('@{\\qquad\\qquad}', '')
  data = re.sub('([^\\\\])[$]', '\\1', data)
  data = '\\mathrm{' + data + '}'

  if data in cache:
    return cache[data]

  macros = {}
  while True:
    start, end = FindMatching(data, '\\def\\')
    if start is None:
      break
    parts = data[start:end]
    name_end = parts.find('#')
    assert name_end > 0
    name = parts[len('\\def'):name_end]
    value = parts[name_end+len('#1'):end]
    macros[name] = value
    data = data[:start] + data[end:]
  for k, v in macros.items():
    while True:
      start, end = FindMatching(data, k + '{')
      if start is None:
        break
      data = data[:start] + v.replace('#1', data[start+len(k):end]) + data[end:]
  p = subprocess.Popen(
      ['node', os.path.join(SCRIPT_DIR, 'katex/cli.js'), '--display-mode', '--trust'],
      stdin=subprocess.PIPE, stdout=subprocess.PIPE, text=True)
  ret = p.communicate(input=data)[0]
  if p.returncode != 0:
    sys.stderr.write('BEFORE:\n' + old + '\n')
    sys.stderr.write('AFTER:\n' + data + '\n')
    raise Exception()
  ret = ret.strip()
  ret = ret[ret.find('<span class="katex-html"'):]
  ret = '<span class="katex-display"><span class="katex">' + ret
  # w3c validator does not like negative em.
  ret = re.sub('height:[-][0-9][.][0-9]+em', 'height:0em', ret)
  # Fix ahref -> a href bug (fixed in next release).
  ret = ret.replace('<ahref="<a', '<a href="')
  # Fix stray spans that come out of katex.
  ret = re.sub('[<]span class="vlist" style="height:[0-9.]+em;"[>]',
               '<span class="vlist">', ret)
  assert HasBalancedTags(ret)

  cache[data] = ret
  return ret


def Main():
  fixups = []

  # TODO(bradnelson, tabatkins): Fix bikeshed to not muck up <pre>.
  def StripParas(match):
    ret = match.group(1)
    ret = ret.replace('\n<p><span class="k">case', '\n   <span class="k">case')
    ret = ret.replace('<p>', '')
    ret = ret.replace('</p>', '')
    return ret

  def ExtractMath(match):
    fixups.append(
        (match.group(1), match.group(2), match.group(3), match.group(4),
         match.start(), match.end()))
    return 'x' * len(match.group())

  data = open(sys.argv[1]).read()
  cache = shelve.open('%s.%d.cache' % (sys.argv[1], CACHE_VERSION))
  # Drop index + search links.
  data = data.replace(
      '<link href="genindex.html" rel="index" title="Index">', '')
  data = data.replace(
      '<link href="search.html" rel="search" title="Search">', '')
  # Drop Navigation.
  data = data.replace(
      '<h3 class="heading settled" id="navigation">'
      '<span class="content">Navigation</span></h3>', '')
  data = data.replace(
      '<li class="nav-item nav-item-0"><a href="index.html#document-index">'
      'WebAssembly 1.0</a> »', '')
  # Drop sphinx css.
  data = data.replace(
      '<link href="_static/classic.css" rel="stylesheet" type="text/css">', '')
  # Fix sphinx css
  data = data.replace(
      '<link href="_static/pygments.css" rel="stylesheet" type="text/css">',
      '<link href="pygments.css" rel="stylesheet" type="text/css">')
  # Bad duplicate meta.
  data = ''.join(data.rsplit(
      '<meta content="text/html; charset=utf-8" http-equiv="Content-Type">', 1))
  # Drop several scripts.
  data = re.sub('<script[^>]*text/javascript[^>]*>[^<]*</script>', '', data)
  data = data.replace(
      '<head>\n', '<head>\n<link rel="stylesheet" href="katex/dist/katex.css">')
  # Drop duplicate title.
  data = data.replace(
      '<title>WebAssembly 1.0</title>', '')
  # valign="top"/"bottom" fails w3c validator.
  data = data.replace(' valign="top"', '')
  data = data.replace(' valign="bottom"', '')
  # frame="void" fails w3c validator.
  data = data.replace(' frame="void"', '')
  # rules="none" fails w3c validator.
  data = data.replace(' rules="none"', '')
  # width="*" angers w3c validator.
  data = re.sub(' width="[0-9]+%"', '', data)
  # border="1" angers w3c validator.
  data = data.replace(' border="1"', '')
  # Get rid of gray bars.
  data = data.replace(
      '<blockquote>', '<blockquote style="border-color: transparent">')
  # Strip <p> in <pre>
  data = re.sub('(<pre>.*?</pre>)', StripParas, data, 0, re.DOTALL)

  # Work around W3C forcing links to have underline for math fragments.
  data = data.replace('<style>',
"""<style>/* mathjax2katex fixes */
.katex-display a[href] {
  border-bottom: 0;
}
</style>
<style>""" , 1)

  # Pull out math fragments.
  data = re.sub(
      'class="([^"]*)math([^"]*)"[^>]*>'
      '((?:[ ]*<span[^>]*>[^<]*</span>)*)([^<]*)<',
      ExtractMath, data)

  sys.stderr.write('Processing %d fragments.\n' % len(fixups))

  done_fixups = []
  success = True

  def Worker():
    nonlocal success
    while True:
      cls_before, cls_after, spans, mth, start, end = q.get()
      try:
        fixed = ('class="' + cls_before + ' ' + cls_after + '">' +
                 spans + ReplaceMath(cache, mth) + '<')
        done_fixups.append((start, end, fixed))
      except Exception:
        success = False

      q.task_done()
      sys.stderr.write('.')

  q = queue.Queue()
  for i in range(len(os.sched_getaffinity(0)) if "sched_getaffinity" in dir(os)
                 else multiprocessing.cpu_count()):
    t = threading.Thread(target=Worker)
    t.daemon = True
    t.start()

  for item in fixups:
    q.put(item)
  q.join()

  if not success:
      sys.stderr.write('\n!!! Error processing fragments\n')
      cache.close()
      sys.exit(1)

  result = []
  last = 0
  for start, end, value in sorted(done_fixups):
    result.append(data[last:start])
    result.append(value)
    last = end
  result.append(data[last:])

  sys.stderr.write('\nProcessing Done.\n')
  sys.stdout.write(''.join(result))
  cache.close()


Main()
