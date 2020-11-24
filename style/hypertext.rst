=========
Hypertext
=========

Links
=====


Link text
---------

As a general rule of thumb, it is better to phrase hyperlinks so that the link
text itself functions as a standalone noun phrase. 

Here's one example:

    To sign a CrateDB Cloud Contract via AWS, simply follow the `link
    <http://example.com/>`_ to the Contract page on the AWS Marketplace.

You can improve the link text by using the link text to describe the
destination of the link, like so:

    To sign a CrateDB Cloud Contract via AWS, visit the `contract page
    <http://example.com/>`_ on the AWS Marketplace.

*Note*
  Link text noun phrases should not be self-referential. That is, the noun phrase should identify the destination, not the link itself. For example, `this link to an example page <http://example.com>`_ uses a noun phrase for the link text. However, the object refered to by that noun phrase is *the link itself* and the goal here is that link text refers to the *destination* of the link.

  A link is a bit like a sign post. It would be unusual to construct a physical sign post with the text "this sign points the way to the city center". A better label would be "city center".

A good way to think about this is to consider the fact that some `screen
readers`_ (assistive technology for browsing the web) construct a separate list
of all links in the document as a sort of ersatz navigation menu.

To imagine what this is like, take every link and add the link text (by itself)
to a bullet point list. Then, consider whether the purpose of each link is still
clear.

For example, the link in the first example above might appear to the visitor on
a generated list like this:

* `Azure Marketplace <http://example.com/>`_
* `AWS Marketplace <http://example.com/>`_
* `Sales team (mailto) <mailto:webmaster@example.com>`_
* `initial steps for signup <http://example.com/>`_
* `link <http://example.com/>`_
* `Azure offer page <http://example.com/>`_
* `AWS offer page <http://example.com/>`_

In this instance, the link text ("link") does not adequately indicate to the
visitor where the link will take them, so it is a good candidate for being
rephrased.

Here's another example:

    For more information on choosing the right subscription plan, refer to our
    documentation `on the subject <http://example.com/>`_.

This would translate to the following link list item:

* `on the subject <http://example.com/>`_

However, if the original text is phrased like this:

    For more information on choosing the right subscription plan, refer to our
    documentation on `subscription plans <http://example.com/>`_.

This link text functions well as a standalone link. However, the resulting
sentence is a litte repetitive. Here's one suggested rewording that reduces the
repetition:

    For more information, refer to our documentation on `choosing a
    subscription plan  <http://example.com/>`_.


.. _screen readers: https://en.wikipedia.org/wiki/Screen_reader
