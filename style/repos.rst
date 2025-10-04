======================
Repository Style Guide
======================

This is a work in progress and may be out-of-date. Please contribute, if you can.

If you have any questions, please contact the `@crate/tech-writing <https://github.com/orgs/crate/teams/tech-writing>`_ team.

.. rubric:: Table of Contents

.. contents::
   :local:


.. _general

General
=======

.. _markup

Markup languages
----------------

We use reStructuredText_ (RST) for most text files on GitHub because this is
also the markup language used by Sphinx_, our primary documentation system.

Having everything written using RST makes writing and editing documents a
standard experience across all repositories and makes it easy to copy and
paste content from one location to another.

In addition, we are in the process of rolling out automated style checks for
any documents that use RST, so it's good to have them in RST for that reason
too.


.. _top-level-files

Top-level files
===============

.. _mandatory

Mandatory Files
---------------

Every repository, at a minimum, must contain the following top-level files:

1. `LICENSE <license>`_
2. `NOTICE <notice>`_
3. `README.rst <readme>`_
4. `CONTRIBUTING.rst <contributing>`_
5. `CODE_OF_CONDUCT.rst <code-of-conduct>`_


.. _licence

``LICENSE``
~~~~~~~~~~~

Example: `LICENSE <https://github.com/crate/crate/blob/master/LICENSE>`_ (`crate/crate <https://github.com/crate/crate>`_)

Copy the text verbatim from one the example ``LICENSE`` file above. However, cut the text at the first horizontal rule (composed of multiple repeating `=` characters).

For any third-pary components included in the project:

1. Add a new horizontal rule composed of multiple repeating `=` characters, with two empty newlines above, and one empty newline below.

2. Identify the affected files (e.g., "For the `blackbox/docs` directory:") followed by a newline

3. List the full copyright notice for those files followed by a newline

4. Copy the license text verbatim


.. _notice

``NOTICE``
~~~~~~~~~~

Example: `NOTICE <https://github.com/crate/crate/blob/master/NOTICE>`_ (`crate/crate <https://github.com/crate/crate>`_)

Copy the text verbatim from the example ``LICENSE`` file above. However, cut the text at the first horizontal rule (composed of multiple repeating `=` characters).

If any included third-party software is distributed with a ``NOTICE`` file, you must copy the text of that file to the top-level ``NOTICE`` file verbatim. If you do so, seperate the addition with a new horizontal rule composed of multiple repeating `=` characters, with two empty newlines above, and one empty newline below.

.. _readme

``README.rst``
~~~~~~~~~~~~~~

Example: `README.rst <https://github.com/crate/crate/blob/master/README.rst>`_ (`crate/crate <https://github.com/crate/crate>`_)

The ``README.rst`` file should be written as an introduction to the project for software engineers.

It is good practice to include:

1. A title (using proper `title case <http://individed.com/code/to-title-case/>`_)

2. A one-paragraph description of the software

3. A longer section going into more detail about the software

4. One or more screenshots (if applicable)

5. A quick-start guide that shows the reader how to use the software

6. A *Contributing* section (copy the text from the main `crate/crate <https://github.com/crate/crate>`_ `README.rst <https://github.com/crate/crate/blob/master/README.rst>`_

7. A *Help* section with links to the documentation and applicable support channels


.. _contributing

``CONTRIBUTING.rst``
~~~~~~~~~~~~~~~~~~~~

Example: `CONTRIBUTING.rst <https://github.com/crate/crate/blob/master/CONTRIBUTING.rst>`_ (`crate/crate <https://github.com/crate/crate>`_)

Copy the text verbatim from the example ``CONTRIBUTING.rst`` file above.


.. _code-of-conduct

``CODE_OF_CONDUCT.rst``
~~~~~~~~~~~~~~~~~~~~~~~

Example: `CODE_OF_CONDUCT.rst <https://github.com/crate/crate-operator/blob/master/CODE_OF_CONDUCT.rst>`_ (`crate/crate-operator <https://github.com/crate/crate-operator>`_)

Copy the text verbatim from the example ``CODE_OF_CONDUCT.rst`` file above.

Note: At the moment, most *Code of Conduct* files are formatted using Markdown. This is a `known bug <https://github.com/crate/tech-writing-domain/issues/344>`_ and will be fixed.


.. _optional

Optional Files
--------------

This section needs expanding.


.. _changes

``CHANGES.rst``
~~~~~~~~~~~~~~~

This section needs expanding.


Top-level directories
=====================


``docs``
--------

The ``docs`` directory is reserved for use as a Sphinx_ documentation project.

All Sphinx projects must use a top-level directory named ``docs``.


.. _reStructuredText: http://docutils.sourceforge.net/rst.html
.. _Sphinx: http://sphinx-doc.org/
