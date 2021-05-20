===============
Developer Guide
===============


Documentation
=============

The documentation is written using `Sphinx`_ and `reStructuredText`_.


Working on the documentation
----------------------------

Python >= 3.7 is required.

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

  - Please honor `SemVer`_ when choosing the new version number. If this
    release includes breaking changes, please add the boilerplate notice to the
    top of the changelog entry.

  - Please separate out the changes into sections where it makes sense. Consult
    previous releases for an idea of how to do this.

- Update ``message`` in ``docs/build.json`` to the latest version

- Commit your changes with a message like "Prepare release X.Y.Z"

- Push to ``origin``

- Run ``./devs/tools/create_tag.sh``

- Browse to the `releases page`_ and select the version you just released

- Select *Edit tag*

- Copy and paste the changelog notes for this release (be sure to remove the
  hard line breaks)

- Check the *Preview* tab for display errors and fix if necessary

- Select *Publish release*


.. _@crate/tech-writing: https://github.com/orgs/crate/teams/tech-writing
.. _fswatch: https://github.com/emcrisostomo/fswatch
.. _Read the Docs: http://readthedocs.org
.. _releases page: https://github.com/crate/crate-docs/releases
.. _reStructuredText: http://docutils.sourceforge.net/rst.html
.. _SemVer: https://semver.org/
.. _Sphinx: http://sphinx-doc.org/
