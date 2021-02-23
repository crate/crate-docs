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

      qa      Generate QA telemetry

      reset   Reset the build

You must install `fswatch`_ to use the ``dev`` target.


Continuous integration and deployment
-------------------------------------

CI is configured to run ``make check`` from the ``docs`` directory.

`Read the Docs`_ (RTD) automatically deploys the documentation whenever a
configured branch is updated.

To make changes to the RTD configuration (e.g., to activate or deactivate a
release version), please contact the `@crate/tech-writing`_ team.


Preparing a release
===================

To create a new release:

- Add a new version section to the ``CHANGES.txt`` file
- Update ``message`` in ``docs/build.json`` to the latest version
- Commit your changes with a message like "Prepare release X.Y.Z"
- Push to ``origin``
- Run ``./devtools/create_tag.sh``


.. _@crate/tech-writing: https://github.com/orgs/crate/teams/tech-writing
.. _fswatch: https://github.com/emcrisostomo/fswatch
.. _Read the Docs: http://readthedocs.org
.. _ReStructuredText: http://docutils.sourceforge.net/rst.html
.. _Sphinx: http://sphinx-doc.org/
