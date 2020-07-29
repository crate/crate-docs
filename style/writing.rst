==================
Writing Guidelines
==================

These are our guidelines for writing documentation in terms of orthographic
style, writing conventions, and so forth.

.. rubric:: Table of Contents

.. contents::
   :local:


.. _style-general:

General
=======

We use standard `American English`_.

Unless otherwise specified, we follow `The Chicago Manual of Style`_.

**Tip**:

    We have a company login for the online version of the Chicago Manual of
    Style. If you need to access it, please ask a technical writer for help.


.. _style-specifics:

Specifics
=========


.. _style-spec-punc:

Punctuation
-----------


.. _style-spec-spaces:

Spaces
~~~~~~

Do not use double spaces after a period.

Correct:

.. code-block:: rst


    This is the standard theme. The community edition of CrateDB uses a lighter
    theme.

Incorrect double space:

.. code-block:: rst

    This is the standard theme.  The community edition of CrateDB uses a
    lighter theme.


.. _style-spec-commas:

Commas
~~~~~~

We use `serial commas`_.

Correct:

.. code-block:: rst

    CrateDB provides flexibility, scalability, and ease-of-use.

Missing serial comma:

.. code-block:: rst

    CrateDB provides flexibility, scalability and ease-of-use.

Lists should always include the word "and" after the serial comma, even in
headings.

Correct:

.. code-block:: rst

    Insert, Update, and Delete
    ==========================

Missing word:

.. code-block:: rst

    Insert, Update, Delete
    ======================


.. _style-spec-lists:

Lists
-----


.. _style-spec-lists-closed:

Closed
~~~~~~

Use closed lists for simple lists:

* Cras at posuere augue
* Suspendisse quis fermentum quam, at tincidunt nisi
* Etiam convallis dolor nec dolor feugiat

Typically, each list item will be a single sentence and terminal punctuation is
not used.


.. _style-spec-lists-open:

Open
~~~~

Use open lists for more complex list items:

* Integer faucibus, nisl non hendrerit maximus, purus massa dignissim tellus,
  posuere.

* Lacus dolor sit amet tellus. Mauris vel ultrices magna.

  Suspendisse quis fermentum quam, at tincidunt nisi. Etiam convallis dolor nec
  dolor feugiat, non sagittis justo dictum.

* Nullam scelerisque lectus orci, nec rhoncus libero sollicitudin nec.
  Suspendisse dictum eros eu dui lacinia, vitae ullamcorper magna dictum. Etiam
  eget ornare nibh.

Open lists are useful because paragraph spacing makes longer blocks of text
easier to read. Terminal punctuation is used.


.. _style-spec-numbers:

Numbering
---------

Numbers under 10 should be spelled out, unless they're literals (i.e., SQL,
configuration examples, code, etc.). For example, write "three", not "3".

.. NOTE::

    You can make an exception if you are enumerating a list. For example:
    "Step 1" works better than "Step One".

Write "third" and not "3rd", or similar.

Numbers 10 or over should be written using numerals (i.e., "10", not "ten").


.. _style-spec-misc:

Miscellaneous
-------------

The term "ID" is an abbreviation and should always be capitalized in prose.
Lowercase is okay for literals, such as column names or variables (e.g.,
``row_id``).

Use "and" instead of "&".

Do not use "/" (a solidus) where an "and" or "or" will do. You should
restructure your sentence accordingly.

Correct:

.. code-block:: rst

    Unsupported Features and Functions
    ==================================

.. code-block:: rst

    Inner Objects and Nested Objects
    ================================

Incorrect use of a solidus:

.. code-block:: rst

    Unsupported Features / Functions
    ================================

.. code-block:: rst

    Inner/Nested Objects
    ====================

.. NOTE::

    You can make an exception if using "/" is in accordance with common usage
    (e.g., "client/server").


.. _American English: https://en.wikipedia.org/wiki/American_English
.. _serial commas: https://en.wikipedia.org/wiki/Serial_comma
.. _The Chicago Manual of Style: https://www.chicagomanualofstyle.org/home.html
