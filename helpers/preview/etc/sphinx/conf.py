import sphinx_rtd_theme

nitpicky=True

project="HTML Preview"

author = ''

html_permalinks= False
html_show_copyright = False
html_show_sphinx = False
html_experimental_html5_writer = True

extensions = [
    "sphinx_rtd_theme",
]

html_theme = "sphinx_rtd_theme"

html_theme_options = {
    'display_version': False,
    'vcs_pageview_mode': 'raw',
    'collapse_navigation': False,
    'navigation_depth': -1,
}

html_static_path = ['_static']

html_css_files = [
    'custom.css',
]
