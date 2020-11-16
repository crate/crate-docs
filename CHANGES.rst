=======
Changes
=======


Unreleased
==========

- The `qa` target now generates full git log CSV files for each RST file,
  including commit subject. Subject lines can be scanned for keywords (by future
  QA tooling) to help classify commits.

  In the future, additional QA tools can be developed to generate additional
  CSV files. For example, to record information reported by Vale.

  The filename stem used by each CSV file can be used to determine the relevant
  source RST file.


0.4.0 - 2020/09/29
==================

- Add the `qa` target which generates QA telemetry in the form of CSV files for
  post-processing. At the moment, the only information reported is the modified
  date (as reported by Git) and the reviewed date (as manually recorded using
  RST metadata).
- Modified the `lint` target to also produce CSV files for post-processing.


0.3.3 - 2020/07/14
==================

- Remove mention of `delint` target (internal use only)


0.3.2 - 2020/07/14
==================

- Fix un-muted comments


0.3.1 - 2020/07/14
==================

- Improved output by muting some Make rules
- Removed `_no_vale` file from `docs`, which enables Vale testing using local
  test Sphinx project
- Changed `.clone` directory to `.crate-docs-build`, which should be more
  readily understandable for most users
- Improved lint checking output
- Forced a full lint check every time `make dev` or `make check` is run
- Fixed issue with `lint-watch` target not working the first time you run `make
  dev`
- Fixed issue with `bin/lint` not being run via fswatch
- Moved lint files to hidden subdirectory to avoid cluttering the visible file
  tree in text editors


0.3.0 - 2020/06/23
==================

- Renamed project to crate-docs-build


0.2.4 - 2020/04/03
==================

- Disabled proselint.Very rule


0.2.3 - 2019/10/22
==================

- Fix incorrect use of hardcoded build directory path with fswatch


0.2.2 - 2019/10/22
==================

- Add `_no_vale` file feature for disabling Vale lint checks


0.2.1 - 2019/09/13
===================

- Fix Vale config file path


0.2.0 - 2019/08/08
===================

- Improve dependency tracking
- Switch to `src` directory name


0.1.12 - 2019/07/31
===================

- Add `site-packages` to RST skip list


0.1.11 - 2019/07/30
===================

- Improve Make targets
- Streamline `docs/Makefile` (move heavy-lifting to `rules.mk`)


0.1.10 - 2019/07/09
===================

- Add `style.json` for use with https://shields.io/endpoint for creating GitHub
  badges
- Fixed conditional `$(STYLE_DIR)` rules


0.1.9 - 2019/07/08
==================

- Switch to `bin/activate` based target


0.1.8 - 2019/07/08
==================

- Fix use of venv targets
- Improve file ignoring for `sphinx-autobuild`


0.1.7 - 2019/07/08
==================

- Use `activate`, don't hardcode venv paths


0.1.6 - 2019/07/05
==================

- Fix `dev` target prerequisites


0.1.5 - 2019/07/03
==================

- Move PATH manipulation to lint script
- Include latest release number in reference `doc/Makefile`
- Activate the Python venv before running Sphinx
- Separate `clean` and `reset` targets


0.1.4 - 2019/07/01
==================

- Add documentation stub for dogfooding purposes
- Add link to GitHub in Makefile comment
- Touch source files when the lint fails so they get picked up by Make
  for linting again
- Fix dependencies for `dev` target
- Fix `lint-watch` target


0.1.3 - 2019/06/28
==================

- Specify Python 3.7


0.1.2 - 2019/06/28
==================

- Removed out-of-date comments
- Standardized target names


0.1.1 - 2019/06/28
==================

- Drop need to use STYLE_DIR environment variable


0.1.0 - 2019/06/27
==================

- Use a .style directory for reliable self-testing


0.0.4 - 2019/06/26
==================

- Fix invokation of pip


0.0.3 - 2019/06/26
==================

- Fixed ROOT_DIR variable name


0.0.2 - 2019/06/26
==================

- Implement lint file based testing approach
- Add lint-watch target using fswatch
- Switch to using pre-built Vale binaries
- Added Travis CI integration
- Automatically install Python dependencies


0.0.1 - 2019/06/11
==================

- Add Makefile
- Drop doc8 (buggy, inactive project)


0.0.0 - 2019/06/10
==================

- Add doc8 configuration
- Add minimal Vale configuration
