============================
CrateDB Documentation System
============================

|version| |ci| |rtd|

Build system, authoring and QA tools, and a style guide for the
`CrateDB documentation`_.


🧐 What's Inside
================

This section gives you an overview about what's inside the relevant
folders.

-   **docs** contains an example documentation instance for demonstration purposes.

-   **tools** includes the `github-projects.txt`_ and `sphinx-inventories.txt`_
    files, which enumerate all repositories and target URLs that resemble
    the documentation at https://cratedb.com/docs/.


Usage
=====

🍀 Tools
--------

A few operational tasks are defined within the top-level ``tasks.py`` file.
After setup::

    git clone https://github.com/crate/crate-docs
    cd crate-docs
    python3 -m venv .venv
    source .venv/bin/activate
    pip install -r requirements.txt

you can display a list of available tasks using::

    invoke --list

There is also tooling to support `Technical Writing on HubSpot`_.

🔗 Intersphinx
--------------

For displaying a list of intersphinx_ link targets per project,
run commands like this::

    invoke inv https://cratedb.com/docs/crate/reference/en/latest/objects.inv
    invoke allinv --format=markdown


Contributing
============

This project is primarily maintained by `Crate.io`_, but we welcome community
contributions!

See the `developer docs`_ and `contributor docs`_ for more information.


Help
====

Looking for more help?

- Check out our `support channels`_
- Read our `Code of Conduct`_


.. |version| image:: https://img.shields.io/endpoint.svg?color=blue&label=docs%20build%20version&url=https://raw.githubusercontent.com/crate/crate-docs/main/docs/build.json
    :alt: Build version
    :target: https://github.com/crate/crate-docs/blob/main/docs/build.json

.. |ci| image:: https://github.com/crate/crate-docs/workflows/docs/badge.svg
    :alt: CI status
    :target: https://github.com/crate/crate-docs/actions/workflows/docs.yml

.. |rtd| image:: https://readthedocs.org/projects/crate-docs/badge/?version=latest
    :alt: Read The Docs status
    :target: https://readthedocs.org/projects/crate-docs


.. _Code of Conduct: CONTRIBUTING.rst
.. _contributor docs: CONTRIBUTING.rst
.. _Crate.io: https://cratedb.com/
.. _CrateDB documentation: https://cratedb.com/docs/
.. _developer docs: DEVELOP.rst
.. _github-projects.txt: tools/github-projects.txt
.. _intersphinx: https://www.sphinx-doc.org/en/master/usage/extensions/intersphinx.html
.. _Sphinx: http://www.sphinx-doc.org/en/stable/
.. _sphinx-inventories.txt: tools/sphinx-inventories.txt
.. _support channels: https://cratedb.com/support/
.. _Technical Writing on HubSpot: https://github.com/crate-workbench/hubspot-tech-writing
