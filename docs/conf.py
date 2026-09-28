from crate.theme.rtd.conf.crate_docs import *

# Re-configure sitemap generation URLs.
# This is a project without versioning.
sitemap_url_scheme = "{link}"

# Disable version chooser.
html_context.update({
    "display_version": False,
    "current_version": None,
    "versions": [],
})
