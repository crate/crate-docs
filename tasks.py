# Tech Writing support.
# https://docs.pyinvoke.org/en/stable/getting-started.html
import shlex
import subprocess

from invoke import task


@task
def inv(c, url: str, format_: str = "text"):
    """
    Display intersphinx inventory for individual project, using selected output format.

    Synopsis:

        invoke inv https://cratedb.com/docs/crate/reference/en/latest/objects.inv
        invoke inv https://cratedb.com/docs/crate/reference/en/latest/objects.inv --format=markdown
    """
    cmd = f"linksmith inventory {url} --format={format_}"
    subprocess.check_call(shlex.split(cmd))


@task
def allinv(c, format_: str = "text"):
    """
    Display intersphinx inventory for all projects, using selected output format.

    Synopsis:

        invoke allinv
        invoke allinv --format=markdown
    """
    cmd = f"linksmith inventory https://github.com/crate/crate-docs/raw/main/registry/sphinx-inventories.txt --format={format_}"
    subprocess.check_call(shlex.split(cmd))
