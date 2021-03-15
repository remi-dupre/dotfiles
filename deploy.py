#!/usr/bin/env python3
import stat
from pathlib import Path
from shutil import copystat

import jinja2
import toml


PROJECT_PATH = Path(__file__).parent
DOTFILES_PATH = PROJECT_PATH / "dotfiles"
DEFAULT_CONFIG_PATH = PROJECT_PATH / "default_config.toml"
HOME_CONFIG_PATH = Path.home() / ".config" / "dotfiles.toml"


def update_recursive(base: dict, other: dict) -> dict:
    def val(key):
        if all(key in x and isinstance(x[key], dict) for x in [base, other]):
            return update_recursive(base[key], other[key])

        return other[key] if key in other else base[key]

    return {key: val(key) for key in {*base.keys(), *other.keys()}}


def load_config() -> dict:
    default_config = toml.load(open(DEFAULT_CONFIG_PATH))

    try:
        return update_recursive(
            default_config,
            toml.load(open(HOME_CONFIG_PATH)),
        )
    except FileNotFoundError:
        return default_config


def real_path(template_path: Path) -> Path:
    path = str(template_path.relative_to(DOTFILES_PATH))
    return Path.home() / path


def main():
    config = load_config()

    for path in filter(Path.is_file, DOTFILES_PATH.rglob("*")):
        mode = stat.S_IMODE(path.stat().st_mode)
        print(f"[{mode}] {path.relative_to(Path.cwd())} -> {real_path(path)}")
        rendered = jinja2.Template(open(path).read()).render(**config)
        open(real_path(path), "w").write(rendered)
        copystat(path, real_path(path))


if __name__ == "__main__":
    main()
