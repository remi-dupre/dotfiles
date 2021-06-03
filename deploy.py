#!/usr/bin/env python3
import subprocess
from pathlib import Path
from shutil import copystat

import jinja2

from util import PROJECT_PATH
from util.config import load_config
from util.print import Style


DOTFILES_PATH = PROJECT_PATH / "dotfiles"
BINARY_FILETYPES = [".jpg", ".png"]


class State:
    def run(self, verbose: bool = False):
        self.display(verbose)

        if self.changed():
            self.apply()

    def changed(self) -> bool:
        raise NotImplementedError

    def display(self, verbose):
        raise NotImplementedError

    def apply(self):
        raise NotImplementedError


class GSettings(State):
    def __init__(self, schema: str, key: str, val: str):
        self.schema = schema
        self.key = key
        self.val = val

    def current(self) -> str:
        return (
            subprocess.check_output(["gsettings", "get", self.schema, self.key])
            .decode()
            .strip()[1:-1]
        )

    def changed(self) -> bool:
        return self.current() != self.val

    def display(self, verbose):
        style = Style.CHANGED if self.changed() else Style.UNCHANGED
        style.print(f"{self.schema}: {self.key} = {self.val}")

    def apply(self):
        subprocess.call(["gsettings", "set", self.schema, self.key, self.val])


class BinaryFile(State):
    def __init__(self, path: Path):
        self.path = path

    def target_path(self) -> Path:
        return Path.home() / self.path.relative_to(DOTFILES_PATH)

    def changed(self) -> bool:
        return not (
            self.target_path().exists()
            and self.path.read_bytes() == self.target_path().read_bytes()
            and self.path.stat().st_mode == self.target_path().stat().st_mode
        )

    def display(self, verbose):
        style = Style.CHANGED if self.changed() else Style.UNCHANGED
        style.print(f" {self.target_path()}")

    def apply(self):
        self.target_path().write_bytes(self.path.read_bytes())
        copystat(self.path, self.target_path())


class TemplateFile(State):
    def __init__(self, path: Path, config: dict):
        self.path = path
        self.config = config

    def target_path(self) -> Path:
        return Path.home() / self.path.relative_to(DOTFILES_PATH)

    def render(self) -> str:
        return jinja2.Template(self.path.read_text()).render(**self.config)

    def changed(self) -> bool:
        return not (
            self.target_path().exists()
            and self.render() == self.target_path().read_text()
            and self.path.stat().st_mode == self.target_path().stat().st_mode
        )

    def display(self, verbose: bool = False):
        style = Style.CHANGED if self.changed() else Style.UNCHANGED
        style.print(f"f{self.target_path()}")

    def apply(self):
        self.target_path().write_text(self.render())
        copystat(self.path, self.target_path())


def real_path(template_path: Path) -> Path:
    path = str(template_path.relative_to(DOTFILES_PATH))
    return Path.home() / path


def main():
    print("===== dotfiles =====")
    config = load_config()

    for path in filter(Path.is_file, DOTFILES_PATH.rglob("*")):
        if any(str(path).endswith(ext) for ext in BINARY_FILETYPES):
            entry = BinaryFile(path)
        else:
            entry = TemplateFile(path, config)

        entry.run()

    if "gsettings" in config:
        for schema, reccords in config["gsettings"].items():
            print(f"\n===== gsettings: {schema} =====")

            for key, val in reccords.items():
                GSettings(schema, key, val).run()


if __name__ == "__main__":
    main()
