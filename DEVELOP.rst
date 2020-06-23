===============
Developer Guide
===============

Documentation
=============

The documentation is written using `Sphinx`_ and `ReStructuredText`_.


Working on the documentation
----------------------------

Python 3.7 is required.

Change into the ``docs`` directory:

.. code-block:: console

    $ cd docs

For help, run:

.. code-block:: console

    $ make

    Crate Docs Build

    Run `make <TARGET>`, where <TARGET> is one of:

      dev     Run a Sphinx development server that builds and lints the
              documentation as you edit the source files

      html    Build the static HTML output

      check   Build, test, and lint the documentation

      delint  Remove any `*.lint` files

      reset   Reset the build cache

You must install `fswatch`_ to use the ``dev`` target.


Continuous integration and deployment
-------------------------------------

|build| |travis| |rtd|

Travis CI is `configured`_ to run ``make check`` from the ``docs`` directory.
Please do not merge pull requests until the tests pass.

`Read the Docs`_ (RTD) automatically deploys the documentation whenever a
configured branch is updated.

To make changes to the RTD configuration (e.g., to activate or deactivate a
release version), please contact the `@crate/docs`_ team.


Preparing a release
===================

To create a new release:

- Add a new version section to the ``CHANGES.txt`` file
- Update ``message`` in ``docs/build.json`` to the latest version
- Commit your changes with a message like "Prepare release X.Y.Z"
- Push to ``origin``
- Run ``./devtools/create_tag.sh``


.. _@crate/tech-writing: https://github.com/orgs/crate/teams/tech-writing
.. _configured: https://github.com/crate/crate-docs-build/blob/master/.travis.yml
.. _fswatch: https://github.com/emcrisostomo/fswatch
.. _Read the Docs: http://readthedocs.org
.. _ReStructuredText: http://docutils.sourceforge.net/rst.html
.. _Sphinx: http://sphinx-doc.org/


.. |build| image:: https://img.shields.io/endpoint.svg?color=blue&url=https%3A%2F%2Fraw.githubusercontent.com%2Fcrate%2Fdocs%2Fmaster%2Fdocs%2Fbuild.json
    :alt: Build version
    :target: https://github.com/crate/crate-docs-build/blob/master/docs/build.json

.. |travis| image:: https://img.shields.io/travis/crate/crate-docs-build.svg?style=flat
    :alt: Travis CI status
    :target: https://travis-ci.org/crate/crate-docs-build

.. |rtd| image:: https://readthedocs.org/projects/crate-docs-build/badge/?version=latest
    :alt: Read The Docs status
    :target: https://readthedocs.org/projects/crate-docs-build
