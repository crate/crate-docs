.. _projects-post-release:

================================
Post-Release Docs Update Process
================================

When `CrateDB`_ makes a new stable release, the CrateDB release manager will
ping a tech writer to update the docs.

The `CrateDB docs`_ make use of a special ``latest`` version in the `Read The
Docs`_ versions drop-down (top right-hand corner of the screen). All internal
links point to the ``latest`` version of the CrateDB docs. In turn, we have
configured our HTTP redirects so that any request for the ``latest`` version of
a document is redirected to the version of that document corresponding to the
latest stable release. In this sense, "latest" means "latest stable release".

To keep this system running, every time we make a new CrateDB stable release,
we also need to update the redirects.

You can follow this process to update the redirects after CrateDB has made a
new stable release.

Steps
=====

- Go to https://readthedocs.org/projects/crate/versions/

- Activate the release branch corresponding to the release.

  - If the release is ``4.2.0``, the release branch is ``4.2``

  - If the release is ``4.2.1``, the release branch is ``4.2``

  - If the release is ``4.2.3``, the release branch is ``4.2``

  - And so on...

  You may find that the release branch has not been created yet. Ping one of the engineers about this and wait for it to be created before proceeding.

  At this stage, do not deactivate any versions (this step comes later).

- Go to https://jenkins.crate.io/job/crate_release_and_packaging/job/rebuild_all_docs/

- Select *Build Now* from the left-hand menu

- Refresh the page

- Select *Last build* under the *Permalinks* section in the main content area

- Select *Console Output* from the left-hand menu

- Wait for the job to complete successfully

- Visit https://readthedocs.org/projects/crate/builds/

- Wait for all of the builds to complete successfully. They may be listed as "Triggered", "Cloning", or "Installing" while in progress. Once complete, they will be listed as "Passed" if everything was successful. (You may have to refresh the page to see the new statuses.) If you encounter build errors, you must address those errors before proceeding.

- Switch to your local clone of the https://github.com/crate/salt repository

- Navigate to the ``salt/cr8/a1/bregenz/web/sites/crateio_docs/rewrites`` directory

- Open the ``99_versions.conf`` file

- Skip to the ``Latest versions`` section

- Look for a line like this:

  ```
  rewrite ^/docs/crate/reference/en/latest/(.*)$ /docs/crate/reference/en/4.1/$1 permanent;
  ```

  Update the old version (e.g., ``4.1``) to the new version you have activated.

  For example, if you have activated ``4.2.``, change the above to:

  ```
  rewrite ^/docs/crate/reference/en/latest/(.*)$ /docs/crate/reference/en/4.2/$1 permanent;
  ```

  This redirect allows us to link to pages in the documentation corresponding to the latest stable release version by using ``/latest/`` as the version parameter in URLs.

  All links to the documentation should use ``/latest/`` as the version parameter unless there is a good reason to link to a specific version number.

- Skip to the *Active versions* section

- Each active release line should have a corresponding entry, like so:

  ```
  rewrite ^/docs/crate/reference/en/4\.(?!1/)[^/]*/(.*)$ /docs/crate/reference/en/4.1/$1 permanent;
  ```

  This redirect checks for any 4.x version that doesn't match the latest feature release (e.g., ``4.1``) for that release line and redirects the request to the latest feature release version (e.g., ``4.1``). In this example, this redirect forces all 4.x versions to resolve to 4.1.

  For example, if you have activated version 4.2, change the above to:

  ```
  rewrite ^/docs/crate/reference/en/4\.(?!2/)[^/]*/(.*)$ /docs/crate/reference/en/4.2/$1 permanent;
  ```

  Or, for example, if you have activated version ``5.0``, add a new entry:

  ```
  rewrite ^/docs/crate/reference/en/5\.(?!0/)[^/]*/(.*)$ /docs/crate/reference/en/5.0/$1 permanent;
  ```

  Double-check the whole collection of *Active versions* redirects to make sure it matches the Read the Docs setup. There is a chance that existing redirects are broken or out-of-date.

- Skip to the *Deactivated versions* section

- We only host documentation for the latest feature release (e.g., ``3.3``) of any release line (e.g., 3.x).

  So, for example, if we want to host documentation for the 4.x and 3.x release lines, we activate versions ``4.2`` and ``3.3`` (assuming these correspond to the highest feature release for each major release line).

  Chat to the release manager to determine which release lines we want to remain active.

- Each release line that will be deactivated should have a corresponding entry in this section, like so:

  ```
  rewrite ^/docs/crate/reference/en/2\.[^/]*/(.*)$ /docs/crate/reference/en/latest/$1 permanent;
  ```

  If you have deactivated any release lines, make sure to add an entry like this one.

  For example, if you have deactivated version ``3.3``, add a new entry:

  ```
  rewrite ^/docs/crate/reference/en/3\.[^/]*/(.*)$ /docs/crate/reference/en/latest/$1 permanent;
  ```

- Run ``git add salt/cr8/a1/bregenz/web/sites/crateio_docs_rewrites.conf``

- Run ``git status`` (or some such)

- Run ``git checkout -b nomi/latest-4.2`` (replace ``nomi`` with whatever string you use for your own branches and replace ``4.2`` with the appropriate version number)

- Run ``git push``

- Visit https://github.com/crate/salt and follow the prompts to create a new pull request

- Ask for a review from a sysadmin

- Once you have an approval, ask the sysadmin to merge your pull request and deploy the changes

- Now the redirects are in place, you can safely deactivate the versions on RTD.

  Go back to the versions page on RTD and hide the versions we no longer want to host by selecting *Edit*. On the next screen, deselect *Active*, select *Hide*, and then *Save*.

- Go to https://jenkins.crate.io/job/crate_release_and_packaging/job/rebuild_all_docs/ and repeat the same process as before to rebuild all of the docs. Wait for this process to complete fully.

- Visit https://jenkins.crate.io/job/crate.io/job/fastly_purge/

- Select *Build with Parameters* from the left-hand menu

- Select *Build* to purge the cache

- Open a private browsing tab (also known as *incognito*) so that any locally cached redirects are ignored

- Visit https://crate.io/docs/crate/reference/en/latest/

- Verify that you are redirected to https://crate.io/docs/crate/reference/en/4.2/

- Select the ``4.2`` drop-down at the top-right of the documentation

- Verify that ``master`` is an option and can be used to view the documentation for the ``master`` branch

- Verify that the other release branches are an option and can be used to view documentation for those release branches

- Notify the release manager that the RTD work has been completed


.. _CrateDB: https://github.com/crate/crate
.. _CrateDB docs: https://crate.io/docs/crate/reference/en/latest/
.. _Read The Docs: https://readthedocs.org/
