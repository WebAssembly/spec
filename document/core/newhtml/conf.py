# -*- coding: utf-8 -*-
#
# Sphinx configuration for bikeshed builds (make bikeshed).
# This imports the main document/core/conf.py, then overwrites certain config
# values for the bikeshed build.

import os
import sys
original_pwd = os.path.abspath('..')
# Change sys.path so that we can find the main 'conf.py'.
sys.path.insert(0, original_pwd)
from conf import *
main_conf_pwd = pwd

# Now that we have imported all the settings, we need to overwrite some of
# them.

# The first is `pwd`, we want to reset it to document/core, because rst_prolog
# below depends on this to find macros.def.
pwd = original_pwd

# Overwrite html themes and configurations.
html_theme = 'basic'
html_theme_options = {
  'nosidebar': True,
}
html_css_files = ['https://www.w3.org/StyleSheets/TR/2016/W3C-ED', 'custom.css']

html_static_path = ['../static']
html_logo =  '../static/webassembly.png'

# Look for layout.html in this directory, it overwrites the underlying theme's
# layout to remove some bits we don't need.
templates_path = ['.']

# Overwrite the prolog to make sure the include directive has the correct path.

main_macros_def = "/" + main_conf_pwd + "/util/macros.def"
# If we hit this assertion, the configuration files probably moved, or files
# are renamed, and we have to update rst_prolog accordingly.
assert(main_macros_def in rst_prolog)
rst_prolog  = rst_prolog.replace(main_macros_def, "/" + pwd + "/util/macros.def")

tags.add('newhtml')
