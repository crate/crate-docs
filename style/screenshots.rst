=====================
Screenshot Guidelines
=====================

Follow this process to create the best screenshots for our documentation.

.. rubric:: Table of Contents

.. contents::
   :local:


.. _screenshots-general:

General instructions
====================


.. _screenshots-os:

Operating system
----------------

All screenshots should be taken on the latest edition of macOS, unless the
screenshot relates to a different specific operating system.

Good:

* Using macOS to document the visual look of admin UI.
* Using Windows to document the visual look of a CrateDB .NET workflow.

Bad:

* Using Linux to document the visual look of admin UI.

.. _screenshots-browser:

Choice of browser
-----------------

Unless the choice of browser is important for what you are documenting, you
should use the standard browser that comes with your operating system. For
macOS, that is Safari.


.. _screenshots-what:

What to include in a screenshot
-------------------------------

Try to capture an entire window, whether that's the full app window, browser
window, or something like the window of a modal dialogue box.

Resist the temptation to only take a screenshot of part of a window. If you
want to draw the reader's attention to a portion of the window, instead, add a
new paragraph under the screenshot with a verbal instruction that directs the
reader's attention.

For example:

    "Here, select the *Home* icon from the right-hand side of the top
    navigation bar."

Good:

* Capturing the full browser window of a web page.
* Capturing only the alert dialogue that pops up when you click some
  part of the parent app's user interface.

Bad:

* Taking a screenshot of an interface and then cropping the image to
  focus in on a specific part.


.. _screenshots-size:

Window sizes
------------

Because you will be taking screenshots of a full window, it becomes important
to size that window properly.

Some general principles:

* The size of a window should not change.

  If you are taking multiple screenshots of the same window, they should all be
  taken at exactly the same size. Ideally, this standard size is used
  throughout the whole documentation project, not just throughout a single
  page.

* Large windows are good. But not too large. Try to size the window as close as
  possible to 1280px (width) by 800px (height).

Some tips:

* You can double check that screenshots of the same window are the same size by
  loading them in an image preview application and cycling between them.

* If you're taking a screenshot of a browser window, there are plugins
  (`example`_) that resize the window to a size of your choosing. You can use a
  plugin like this to ensure a consistent size.

* On macOS, do not maximize the window into a new space. This hides the
  standard window `chrome`_ (e.g., the red, yellow, and green dots in the title
  bar), which is an important component of the screenshot.

  To better maximize a window, hold down *Option (⌥)* as you click the blue
  button in the window title bar.


.. _screenshots-shadow:

Drop shadows
------------

By default, macOS includes a drop shadow when creating a screenshot. This is
correct for screenshots. If necessary, enable drop shadows.


.. _chrome: https://www.nngroup.com/articles/browser-and-gui-chrome/
.. _example: https://mehlau.net/resizewindow/
