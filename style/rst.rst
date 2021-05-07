==============
RST Guidelines
==============

At Crate.io, our documentation is written in RST. In order to create a uniform
standard for writing our RST, we have developed some guidelines. Following
these guidelines is required for contributions to our documentation. For ease
of use, we have gathered them in this document below.

.. rubric:: Table of Contents

.. contents::
   :local:


.. _general:

General
=======


.. _line-lengths:

Line lengths
------------

With the exception of pre-formatted text (e.g., literals and code blocks), as
well as link URLs, lines should not exceed 79 characters. Lines should be
wrapped as closely to 79 characters per line as possible, without exceeding
that limit.

**TIP**
  Good text editors allow you to set a visual page margin indicator.


.. _whitespace:

Whitespace
-----------

Separate block-level elements with a single empty line.

Correct:

.. code-block:: rst

    Section header
    ==============

    The first paragraph.

Incorrect line spacing:

.. code-block:: rst

    Section header
    ==============
    The first paragraph.

**NOTE**
  In most cases, an RST file should never contain multiple sequential empty
  lines. Exceptions to this rule include: preformatted text, two empty lines
  preceding headings, and two empty lines preceding link lists.

Additionally:

* Use spaces, not tabs
* Lines should not end with any trailing spaces
* Files should end with a single empty newline

**TIP**
  Good text editors can be configured to take care of spaces instead of tabs,
  trailing spaces, and trailing newlines.


.. _titles-headings:

Titles and headings
===================


.. _titles-headings-markup:

Markup
------


.. _titles-headings-underlines:

Underlines
''''''''''

You should mark up titles and headings with the following underlines:

.. code-block:: rst

    ==========
    Page Title
    ==========

    Top-level heading
    =================

    Second-level heading
    --------------------

    Third-level heading
    '''''''''''''''''''

    Fourth-level heading
    ....................

    Fifth-level heading
    ```````````````````

These underlines were chosen to satisfy the following requirements:

1. Honor the well-established practice of using ``=`` and ``-`` for the first
   three heading levels.

2. Underlines should resemble properly typeset underlines (i.e., a single
   continuous line) as much as possible.

   This rules out symbols that do not create the impression of a standard
   underline. Additionally, underlines should sit somewhere between `the median
   and the cap hight`_. Symbols that sit on the baseline leave an undesirable
   amount of vertical space between the underline and the heading text.

4. The visual prominence (defined here as the combination of `point size`_ and
   `type color`_) of the underline should decrease with heading depth (e.g.,
   the fourth-level heading should be less prominent than the third-level
   heading).


.. _titles-headings-preceding-lines:

Preceding empty lines
'''''''''''''''''''''

Headings should be preceded by two empty lines to help visually distinguish the
start of a new section.

Correct:

.. code-block:: rst

    Paragraph belonging to a previous section.


    New section header
    ==================

Incorrect line spacing:

.. code-block:: rst

    Paragraph belonging to a previous section.

    New section header
    ==================


.. _titles-headings-typography:

Typography
----------

Use `title case`_ for page titles and `sentence case`_ for headings.

Mark up literals that occur in a title or heading, e.g.:

.. code-block:: rst

    Using ``COPY FROM``
    ===================


.. _titles-headings-phrasing:

Phrasing
--------

As a general principle, we use the imperative mood for top-level document
titles where an action is relevant. E.g., correct:

.. code-block:: rst

    ================
    Create a cluster
    ================

Incorrect:

.. code-block:: rst

    =======
    Cluster
    =======

Also incorrect:

.. code-block:: rst

    =======================
    How to create a cluster
    =======================

Where an action is not relevant (e.g., reference articles), a simple descriptive
noun will suffice. For example:

.. code-block:: rst

    ========
    Glossary
    ========


.. _labels:

Labels
======

Page titles and headings should be labeled. Labels must be unique within the
scope of a single documentation project.

Use ``-`` characters instead of ``_`` characters to separate words in a label.

Correct:

.. code-block:: rst

    .. _foo-widgets:

    ===========
    Foo Widgets
    ===========

Here, the label for the title is ``foo-widgets``.

Incorrect separating character:

.. code-block:: rst

    .. _foo_widgets:

    ===========
    Foo Widgets
    ===========

The preferred way to link to documents (from within the same documentation
project) is to use the most appropriate label as a *reference*. For example:

.. code-block:: rst

    Consult the :ref:`foo-widgets` section.

By default, this style of link will use the original title or heading text
(including case). You can set your own link text, like this:

.. code-block:: rst

    Next, we'll configure a :ref:`foo widget <foo-widgets>`.

**TIP**
  If you want to link to a page or a subsection of a page but there isn't a
  corresponding title or heading label, you can add one.

**NOTE**
  Long labels (20 characters or more) can be unwieldy to use. Opt for a
  shorthand version of the title or heading if you need to cut things down.


.. _paragraphs:

Paragraphs
==========

You should separate paragraphs with a single empty line.

Correct:

.. code-block:: rst

    Some paragraph text.

    The start of a new paragraph.

Missing separating empty line:

.. code-block:: rst

    Some paragraph text.
    The start of a new paragraph.

Too many empty lines:

.. code-block:: rst

    Some paragraph text.


    The start of a new paragraph.



.. _lists:

Lists
=====


.. _lists-closed:

Closed
------

The list items of a closed list appear as sequential lines with no additional
spacing.

For example:

* Cras at posuere augue
* Suspendisse quis fermentum quam, at tincidunt nisi
* Etiam convallis dolor nec dolor feugiat

Closed lists should be marked up using ``*`` characters, with no initial space
relative to the current indent level, and no spaces between the list items.

Correct:

.. code-block:: rst

    Diam vitae:

    * Cras at posuere augue
    * Suspendisse quis fermentum quam, at tincidunt nisi
    * Etiam convallis dolor nec dolor feugiat

Incorrect bullets:

.. code-block:: rst

    Diam vitae:

    - Cras at posuere augue
    - Suspendisse quis fermentum quam, at tincidunt nisi
    - Etiam convallis dolor nec dolor feugiat

Incorrect indentation level:

.. code-block:: rst

    Diam vitae:

     * Cras at posuere augue
     * Suspendisse quis fermentum quam, at tincidunt nisi
     * Etiam convallis dolor nec dolor feugiat

Incorrect line spacing:

.. code-block:: rst

    Diam vitae:

    * Cras at posuere augue

    * Suspendisse quis fermentum quam, at tincidunt nisi

    * Etiam convallis dolor nec dolor feugiat


.. _lists-open:

Open
----

The list items of an open list appear separated like paragraphs.

Open lists should be marked up using ``*`` characters, with no initial space
relative to the current indent level, and one empty line between list items.
They must also be prefixed with the ``.. rst-class:: open`` directive.

Correct:

.. code-block:: rst

    Diam vitae:

    .. rst-class:: open

    * Integer faucibus, nisl non hendrerit maximus, purus massa dignissim
      tellus, posuere.

    * Lacus dolor sit amet tellus. Mauris vel ultrices magna.

      Suspendisse quis fermentum quam, at tincidunt nisi. Etiam convallis
      dolor nec dolor feugiat, non sagittis justo dictum.

    * Nullam scelerisque lectus orci, nec rhoncus libero sollicitudin nec.
      Suspendisse dictum eros eu dui lacinia, vitae ullamcorper magna dictum.
      Etiam eget ornare nibh.

Missing directive:

.. code-block:: rst

    Diam vitae:

    * Integer faucibus, nisl non hendrerit maximus, purus massa dignissim
      tellus, posuere.

    * Lacus dolor sit amet tellus. Mauris vel ultrices magna.

      Suspendisse quis fermentum quam, at tincidunt nisi. Etiam convallis
      dolor nec dolor feugiat, non sagittis justo dictum.

    * Nullam scelerisque lectus orci, nec rhoncus libero sollicitudin nec.
      Suspendisse dictum eros eu dui lacinia, vitae ullamcorper magna dictum.
      Etiam eget ornare nibh.

Incorrect line spacing:

.. code-block:: rst

    Diam vitae:

    .. rst-class:: open

    * Integer faucibus, nisl non hendrerit maximus, purus massa dignissim
      tellus, posuere.
    * Lacus dolor sit amet tellus. Mauris vel ultrices magna.

      Suspendisse quis fermentum quam, at tincidunt nisi. Etiam convallis
      dolor nec dolor feugiat, non sagittis justo dictum.
    * Nullam scelerisque lectus orci, nec rhoncus libero sollicitudin nec.
      Suspendisse dictum eros eu dui lacinia, vitae ullamcorper magna dictum.
      Etiam eget ornare nibh.


.. _indentation:

Indentation
===========

Literal blocks and admonition blocks should be indented by four characters.

Correct:

.. code-block:: rst

    Here's a code example::

        print("Hello world!")

.. code-block:: rst

    Here's a code example:

    .. code-block::

        print("Hello world!")

.. code-block:: rst

    .. NOTE::

        Some note text.

Incorrect indentation level:

.. code-block:: rst

    .. NOTE::

       Some note text.


.. _link-lists:

Link lists
==========

Order link URL lists alphabetically (case-insensitive) and keep them at the end
of the document.

Links should be listed as a single block and this block should be separated
from the main text by two empty lines.

Correct:

.. code-block:: rst

    Lorem ipsum dolor sit amet.


    .. _Elasticsearch: http://www.elasticsearch.org/
    .. _Lucene: http://lucene.apache.org/core/

Missing double separator:

.. code-block:: rst

    Lorem ipsum dolor sit amet.

    .. _Lucene: http://lucene.apache.org/core/
    .. _Elasticsearch: http://www.elasticsearch.org/

Incorrect separator line between link items:

.. code-block:: rst

    Lorem ipsum dolor sit amet.


    .. _Elasticsearch: http://www.elasticsearch.org/

    .. _Lucene: http://lucene.apache.org/core/

Incorrect sort order:

.. code-block:: rst

    Lorem ipsum dolor sit amet.


    .. _Lucene: http://lucene.apache.org/core/
    .. _Elasticsearch: http://www.elasticsearch.org/


.. _point size: https://en.wikipedia.org/wiki/Point_(typography)
.. _sentence case: https://en.wiktionary.org/wiki/sentence_case
.. _the median and the cap hight: https://en.wikipedia.org/wiki/Baseline_(typography)#/media/File:Typography_Line_Terms.svg
.. _title case: http://individed.com/code/to-title-case/
.. _type color: https://en.wikipedia.org/wiki/Type_color
