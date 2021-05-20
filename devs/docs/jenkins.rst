============
Jenkins Jobs
============


``rebuild_all_docs``
====================

Job page: `rebuild_all_docs`_

Instructions:

- Select *Build Now* from the left-hand navigation menu.

Under normal circumstances, this is all you have to do. The docs will be
rebuilt on the Read The Docs website. Eventually, the Fastly cache will update,
and the changes will be visible. (You can force a Fastly cache purge. See
below.)

To check up on the build, do this:

- Refresh the page.

- Look under the *Permalinks* heading in the central panel. There should be a
  list of builds. One of them should be from a few seconds or minutes
  ago. (e.g., "Last build (#5), 1 min 4 sec ago").

- Select that link. Alternatively, use the *last build* link, which always
  takes you to the last build.

- On the build page, select *Console Output* to view the console output of the
  build.


``fastly_purge``
=================

Job page: `fastly_purge`_

Instructions:

- Select *Build with Parameters* from the left-hand navigation menu. A new page
  should load.

- The new page will present you with a select menu to choose the *PURGE_KEY*.

  - If you select the ``docs`` *PURGE_KEY*, the Fastly cache for all docs will
    be purged. If you select a project-specific *PURGE_KEY* (e.g.,
    ``docs/crate``), only the Fastly cache for that project will be purged.

  - The *PURGE_KEY* should match the ``Surrogate-Key`` HTTP header set for the
    project-specific nginx reverse-proxy configuration.

  - *The cache is valuable and rebuilding it takes time and resources. You
    should not purge the whole cache if all you want to do is purge the cache
    for one specific project.*

- Once you have chosen a *PURGE_KEY*, select *Build*.

Under normal circumstances, this is all you have to do. The Fastly cache for
the *PURGE_KEY* you selected will be purged.

To check up on the build, do this:

- Refresh the page.

- Look under the *Permalinks* heading in the central panel. There should be a
  list of builds. One of them should be from a few seconds or minutes
  ago. (e.g., "Last build (#203), 57 sec ago").

- Select that link. Alternatively, use the *last build* link, which always
  takes you to the last build.

- On the build page, select *Console Output* to view the console output of the
  build.

.. _rebuild_all_docs: https://jenkins.crate.io/job/crate_release_and_packaging/job/rebuild_all_docs/
.. _fastly_purge: https://jenkins.crate.io/job/crate.io/job/fastly_purge/
