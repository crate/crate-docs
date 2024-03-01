# Tech Writing support.
# https://docs.pyinvoke.org/en/stable/getting-started.html
from pathlib import Path

from sphinx.ext.intersphinx import inspect_main, fetch_inventory
from invoke import task
import typing as t


class SphinxInventoryDecoder:
    """
    Decode and process intersphinx inventories created by Sphinx.

    https://www.sphinx-doc.org/en/master/usage/extensions/intersphinx.html
    """
    def __init__(self, name: str, url: str):
        self.name = name
        self.url = url

    def as_text(self):
        inspect_main([self.url])

    def as_markdown(self):
        class MockConfig:
            intersphinx_timeout: int | None = None
            tls_verify = False
            tls_cacerts: str | dict[str, str] | None = None
            user_agent: str = ''

        class MockApp:
            srcdir = ''
            config = MockConfig()

        app = MockApp()
        inv_data = fetch_inventory(app, '', self.url)  # type: ignore[arg-type]
        print(f"# {self.name}")
        for key in sorted(inv_data or {}):
            print(f"## {key}")
            inv_entries = sorted(inv_data[key].items())
            print("```text")
            for entry, (_proj, _ver, url_path, display_name) in inv_entries:
                display_name = display_name * (display_name != "-")
                print(f"{entry: <40} {display_name: <40}: {url_path}")
            print("```")


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
    urls = Path("./tools/sphinx-inventories.txt").read_text().splitlines()
    for url in urls:
        inv(c, url, format)
