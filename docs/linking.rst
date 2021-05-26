=======
Linking
=======

Short Links
===========

We have configured a number of short links (i.e., URLs) for the docs. These
URLs can be used when the naked URL is going to be visible, for improved
readability and use of character space..


CrateDB:

- crate.io/tutorials/
- crate.io/howtos/
- crate.io/reference/
- crate.io/clients-tools/
- crate.io/admin-ui/
- crate.io/crash/

CrateDB Cloud:

- crate.io/cloud/tutorials/
- crate.io/cloud/howtos/
- crate.io/cloud/reference/
- crate.io/cloud/croud/


Latest versions
===============

The short links always redirect to the latest version of the documentation. So,
for ecample, in the case of the CrateDB Reference,
``http://crate.io/reference/`` will redirect to
``https://crate.io/docs/crate/reference/en/latest/``.

In turn, the ``/en/latest/`` URL will redirect to the latest stable version of
the docs. For example, at the time of writing, that means the final URL is
``https://crate.io/docs/crate/reference/en/4.5/``.

The ``latest`` version *always* redirects to the latest stable version, and as
such, you will never find it visible in the URL bar in your browser.

IF you copy the URL from your browser when you want to link to a page in the
documentation, the URL effectively pins the documentation to the current stable
version. This is fine for in most cases (e.g., for most day-to-day use by
readers).

However, if you are creating more a more permanent cross-reference, in most
cases, you should link using a URL that uses the `latest` version. Doing so
will ensure that the link you created continues to take the reader to the
latest version of that page forever.

Example
-------

Let's say you are adding content to the `inserts performance` section of the CrateDB How-To Guides.



.. _inserts performance: https://crate.io/docs/crate/howtos/en/latest/performance/inserts/index.html
