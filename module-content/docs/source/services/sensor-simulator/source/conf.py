# Configuration file for the Sphinx documentation builder.
#
# This file only contains a selection of the most common options. For a full
# list see the documentation:
# http://www.sphinx-doc.org/en/master/config

# -- Path setup --------------------------------------------------------------

# If extensions (or modules to document with autodoc) are in another directory,
# add these directories to sys.path here. If the directory is relative to the
# documentation root, use os.path.abspath to make it absolute, like shown here.
#
import os
import sys
sys.path.insert(0, os.path.abspath('.'))
sys.path.insert(0, os.path.abspath('../'))


# -- Project information -----------------------------------------------------

project = 'GridAPPSD Sensor Simulator'
copyright = '2019, Pacific Northwest National Laboratory'
author = 'Craig Allwardt'

# The full version, including alpha/beta/rc tags
release = '2019.10.0'


# -- General configuration ---------------------------------------------------
master_doc = 'index'

# Add any Sphinx extension module names here, as strings. They can be
# extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
# ones.
extensions = [
     'sphinx.ext.viewcode',
     'sphinx.ext.autodoc'
]

# Add any paths that contain templates here, relative to this directory.
templates_path = ['_templates']

# List of patterns, relative to source directory, that match files and
# directories to ignore when looking for source files.
# This pattern also affects html_static_path and html_extra_path.
exclude_patterns = []


# -- Options for HTML output -------------------------------------------------

# The theme to use for HTML and HTML Help pages.  See the documentation for
# a list of builtin themes.
#
html_theme = 'sphinx_rtd_theme'

# Add any paths that contain custom static files (such as style sheets) here,
# relative to this directory. They are copied after the builtin static files,
# so a file named "default.css" will overwrite the builtin "default.css".
html_static_path = ['_static']


# def setup(app):
#     """
#     Registers callback method on sphinx events. callback method used to
#     dynamically generate api-docs rst files which are then converted to html
#     by readthedocs
#     :param app:
#     """
#     # app.connect('builder-inited', generate_apidoc)
#    # app.connect('builder-inited', build_gridappsd_python_api)
#     app.connect('builder-inited', generate_apidocs)
#
#     app.connect('build-finished', clean_apirst)
#
#
# def clean_apirst(app, *args):
#     import shutil
#     shutil.rmtree('source/api', ignore_errors=True)
#
#
# def generate_apidocs(app):
#     # repo_path = os.path.abspath('./griappsd-python')
#     # from git import Repo
#     # import subprocess
#     # url = "https://github.com/gridappsd/gridappsd-python"
#     # was_created = False
#     # if os.path.exists(repo_path):
#     #     repo = Repo(repo_path)
#     # else:
#     #     repo = Repo.clone_from(url, repo_path)
#     #     was_created = True
#     #
#     # if not was_created:
#     #     origin = repo.remote('origin')
#     #     origin.fetch()
#     #     origin.pull()
#     #
#     # exclusions = [
#     #     os.path.join(repo_path, '/setup.py')
#     # ]
#     import subprocess
#     cmd = ["sphinx-apidoc", '-M', '-d 4', '-o', 'source/api', '--force',
#            os.path.abspath("../sensors")]
#
#     subprocess.check_call(cmd)
#
#
# # def generate_apidoc(app):
# #     print('BUILIDING JAVADOCS '+ __file__)
# #     print('CWD: '+os.getcwd())
# #     path_to_src = os.path.abspath(os.path.join(os.path.dirname(__file__), '../../pnnl.goss.gridappsd/src'))
# #     path_to_output = os.path.abspath(os.path.join(os.path.dirname(__file__), '../../source'))
# #     print(path_to_src)
# #     cmd = [
# #         'javasphinx-apidoc',
# #         path_to_src,
# #         '-o',
# #         'source/api_docs',
# #         '-c',
# #         'cache'
# #     ]
# #     subprocess.call(cmd)
