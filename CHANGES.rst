=======
Changes
=======


Unreleased
==========


2.1.0 - 2022/07/06
==================

- Allow usage on Sphinx 5


2.0.2 - 2022/06/09
==================

- Update link to sample vale configuration
- Fix version shield and remove demo-docs reference
- Fix Makefile to use python3


2.0.1 - 2022/03/02
==================

Features
--------

- Added the ``preview-rst`` helper script

Fixes
-----

- Fixed no vale case
- Vale ignores ``eggs`` folder


2.0.0 - 2021/03/24
==================

Breaking Changes
----------------

**IMPORTANT**: You must update your Sphinx project's ``Makefile`` to pick up
these changes. See ``docs/Makefile`` for details.

Features
--------

- The `make dev` command now opens a browser window for you once the build is
  ready.

Fixes
-----

- Renamed ``demo-docs`` back to ``docs``.

  We did this so that the reference project looks exactly like how we recommend
  Sphinx projects to look (i.e., residing under ``docs/``). This is also a
  low-effort way to avoid the issue of having to ask users to update the
  Makefile to edit the ``DOCS_DIR`` setting from ``demo-docs`` to ``docs``,
  which would be an unnecessary (and potentially confusing) request.

Fixes
-----

- Fixed the use of the ``--keep-going`` flag that was being erroneously passed
  to ``sphinx-autobuild`` as well as ``sphinx``.


1.1.0 - 2021/03/22
==================

**NOTE**: The 1.1.0 release should have been released as version 2.0.0 because it
contains breaking changes.  This cannot be fixed in retrospect. However, 2.0.0
has subsequently been released with additional fixes.


Breaking Changes
----------------

**IMPORTANT**: You must update your Sphinx project's ``Makefile`` to pick up
these changes. See ``demo-docs/Makefile`` for details.

- Renamed directories.

  - The ``src`` directory has been renamed ``common-build``. This directory is
    what we talk about in conversations, so now it is less ambiguous.

  - Renamed the ``docs`` directory to ``demo-docs``. This Sphinx project only
    exists as a demo project that can be used to test the other tools within
    this very repository.

Fixes
-----

- Fix version warning (was warning when the pinned version was up-to-date)

- Add ``--keep-going`` to Sphinx options

- Use explicit version pinning for the Sphinx release, adhering to RTD's
  recommendations about reproducible builds. Currently, we are using
  Sphinx 3.5.3.


1.0.0 - 2021/03/03
==================


Breaking Changes
----------------

**IMPORTANT**: You must update your Sphinx project's ``Makefile`` to pick up
these changes. See ``demo-docs/Makefile`` for details.

- The demo ``Makefile`` now passes the correct target (``html`` or
  ``linkcheck``) through to ``sphinx-build`` (fixes
  https://github.com/crate/crate-docs/issues/30).

- The demo ``Makefile`` file now displays a warning message if you are using an
  out-of-date version of Crate Docs. If you see this message in the future, you
  will know there is an upgrade available for the build system.

- We have silenced Make rules (too noisy and not helpful) and added
  informational messages to let you know what's going on.

- We replaced some ANSI colors with ANSI bold to improve the readability of
  Make output for some consoles.

- We added comments to the demo ``Makefile`` to document how the build system
  works.


Functionality
-------------

- A new ``telemetry`` target now generates a Vale report and full git log CSV
  files for each RST file, including the commit subject.

  We may add a telemetry aggregation app to the Crate Docs project for QA use
  in the future. Ideally, this app would give you a reporting overview for all
  Sphinx projects.

  See <https://github.com/crate/crate-docs/issues/63> for more information and
  status update.

- Bump Vale from version 1.x to the most recent 2.x release.

- Make no longer runs Vale when ``make dev``is run. Running Vale before every
  ``sphinx-autobuild`` was adding a significant delay to the editing workflow.
  This issue was exacerbated by the fact that Vale was run once for individual
  RST file.

  Now, Make runs Vale when ``make check`` is run. Additionally, Vale is run
  once for all files which improves speed.

  Because Vale is no longer necessary to run ``make dev`` or ``make html``,
  there is no need to mock the Vale binary if Vale cannot be installed.
  Accordingly, Make will now error out when ``make check`` or ``make
  telemetry`` are run and Vale cannot be installed because Vale is essential
  for both of these targets.

- Previously, Python 3.7 was required. Now, any version of Python >= 3.7 is
  allowed.

- We are transitioning to Sphinx 3. Accordingly, we have relaxed the Sphinx
  1.7.4 requirement to allow any version of Sphinx < 4.


Fixes
-----

- Disable ``proselint.Annotations`` so that using ``**NOTE**`` in standalone
  RST files does not raise an error.

- The ``.venv`` directory (a Python virtual environment) is now created under
  ``.crate-docs``. This change prevents many developer search tools from
  crossing that boundary and producing unwanted results.


0.4.0 - 2020/09/29
==================

- Add the ``qa`` target which generates QA telemetry in the form of CSV files
  for post-processing. At the moment, the only information reported is the
  modified date (as reported by Git) and the reviewed date (as manually
  recorded using RST metadata).

- Modified the ``lint`` target to also produce CSV files for post-processing.


0.3.3 - 2020/07/14
==================

- Remove mention of ``delint`` target (internal use only)


0.3.2 - 2020/07/14
==================

- Fix un-muted comments


0.3.1 - 2020/07/14
==================

- Improved output by muting some Make rules
- Removed ``_no_vale`` file from ``docs``, which enables Vale testing using
  local test Sphinx project
- Changed ``.clone`` directory to ``.crate-docs-build``, which should be more
  readily understandable for most users
- Improved lint checking output
- Forced a full lint check every time ``make dev`` or ``make check`` is run
- Fixed issue with ``lint-watch`` target not working the first time you run
  ``make dev``
- Fixed issue with ``bin/lint`` not being run via fswatch
- Moved lint files to hidden subdirectory to avoid cluttering the visible file
  tree in text editors


0.3.0 - 2020/06/23
==================

- Renamed project to crate-docs-build


0.2.4 - 2020/04/03
==================

- Disabled ``proselint.Very`` rule


0.2.3 - 2019/10/22
==================

- Fix incorrect use of hardcoded build directory path with ``fswatch``


0.2.2 - 2019/10/22
==================

- Add ``_no_vale`` file feature for disabling Vale lint checks


0.2.1 - 2019/09/13
===================

- Fix Vale config file path


0.2.0 - 2019/08/08
===================

- Improve dependency tracking
- Switch to ``src`` directory name


0.1.12 - 2019/07/31
===================

- Add ``site-packages`` to RST skip list


0.1.11 - 2019/07/30
===================

- Improve Make targets
- Streamline ``demo-docs/Makefile`` (move heavy-lifting to ``rules.mk``)


0.1.10 - 2019/07/09
===================

- Add ``style.json`` for use with https://shields.io/endpoint for creating
  GitHub badges
- Fixed conditional ``$(STYLE_DIR)`` rules


0.1.9 - 2019/07/08
==================

- Switch to ``bin/activate`` based target


0.1.8 - 2019/07/08
==================

- Fix use of ``venv`` targets
- Improve file ignoring for ``sphinx-autobuild``


0.1.7 - 2019/07/08
==================

- Use ``activate``, don't hardcode ``venv`` paths


0.1.6 - 2019/07/05
==================

- Fix ``dev`` target prerequisites


0.1.5 - 2019/07/03
==================

- Move ``PATH`` manipulation to lint script
- Include latest release number in reference ``doc/Makefile``
- Activate the Python ``venv`` before running Sphinx
- Separate ``clean`` and ``reset`` targets


0.1.4 - 2019/07/01
==================

- Add documentation stub for dogfooding purposes
- Add link to GitHub in Makefile comment
- Touch source files when the lint fails so they get picked up by Make
  for linting again
- Fix dependencies for ``dev`` target
- Fix ``lint-watch`` target


0.1.3 - 2019/06/28
==================

- Specify Python 3.7


0.1.2 - 2019/06/28
==================

- Removed out-of-date comments
- Standardized target names


0.1.1 - 2019/06/28
==================

- Drop need to use ``STYLE_DIR`` environment variable


0.1.0 - 2019/06/27
==================

- Use a ``.style`` directory for reliable self-testing


0.0.4 - 2019/06/26
==================

- Fix invokation of ``pip``


0.0.3 - 2019/06/26
==================

- Fixed ``ROOT_DIR`` variable name


0.0.2 - 2019/06/26
==================

- Implement lint file based testing approach
- Add lint-watch target using ``fswatch``
- Switch to using pre-built Vale binaries
- Added Travis CI integration
- Automatically install Python dependencies


0.0.1 - 2019/06/11
==================

- Add Makefile
- Drop ``doc8`` (buggy, inactive project)


0.0.0 - 2019/06/10
==================

- Add ``doc8`` configuration
- Add minimal Vale configuration
