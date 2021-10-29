# -*- coding: utf-8 -*-
#
# Sphinx configuration for bikeshed builds (make bikeshed).
# This imports the main document/core/conf.py, then overwrites certain config
# values for the bikeshed build.

import os
import sys
original_pwd = os.path.abspath('../..')
# Change sys.path so that we can find the main 'conf.py'.
sys.path.insert(0, original_pwd)
from conf import *
main_conf_pwd = pwd

# Now that we have imported all the settings, we need to overwrite some of
# them.

# The first is `pwd`, we want to reset it to document/core, because rst_prolog
# below depends on this to find macros.def.
pwd = original_pwd

# The bikeshed build requires the mathdefbs extension.
extensions[extensions.index('util.mathdef')] = 'util.mathdefbs'

# Overwrite html themes and configurations.
html_theme = 'classic'
html_permalinks = False
html_theme_options = {
  'nosidebar': True,
}
html_show_copyright = False

# Overwrite the prolog to make sure the include directive has the correct path.

main_macros_def = "/" + main_conf_pwd + "/util/macros.def"
# If we hit this assertion, the configuration files probably moved, or files
# are renamed, and we have to update rst_prolog accordingly.
assert(main_macros_def in rst_prolog)
rst_prolog  = rst_prolog.replace(main_macros_def, "/" + pwd + "/util/macros.def")

del mathjax3_config
