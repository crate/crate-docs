# Tech Writing support.
# https://docs.pyinvoke.org/en/stable/getting-started.html
from pathlib import Path

from invoke import task
import typing as t

from pueblo.sphinx.inventory import SphinxInventoryDecoder


@task
def inv(c, url: str, format: t.Literal["text", "markdown"] = "text"):
    """
    Display intersphinx inventory for individual project, using selected output format.

    Synopsis:

        invoke inv https://cratedb.com/docs/crate/reference/en/latest/objects.inv
        invoke inv https://cratedb.com/docs/crate/reference/en/latest/objects.inv --format=markdown
    """
    name = Path(url).parent.parent.parent.name
    inventory = SphinxInventoryDecoder(name=name, url=url)
    if format == "text":
        inventory.as_text()
    elif format == "markdown":
        inventory.as_markdown()
    else:
        raise NotImplementedError(f"Output format not implemented: {format}")


@task
def allinv(c, format: t.Literal["text", "markdown"] = "text"):
    """
    Display intersphinx inventory for all projects, using selected output format.

    Synopsis:

        invoke allinv
        invoke allinv --format=markdown
    """
    urls = Path("./registry/sphinx-inventories.txt").read_text().splitlines()
    for url in urls:
        inv(c, url, format)
