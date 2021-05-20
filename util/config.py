from pathlib import Path

import toml

from util import PROJECT_PATH


DEFAULT_CONFIG_PATH = PROJECT_PATH / "default_config.toml"
HOME_CONFIG_PATH = Path.home() / ".config" / "dotfiles.toml"


def load_config() -> dict:
    default_config = toml.load(open(DEFAULT_CONFIG_PATH))

    try:
        return update_recursive(
            default_config,
            toml.load(open(HOME_CONFIG_PATH)),
        )
    except FileNotFoundError:
        return default_config


def update_recursive(base: dict, other: dict) -> dict:
    def val(key):
        if all(key in x and isinstance(x[key], dict) for x in [base, other]):
            return update_recursive(base[key], other[key])

        return other[key] if key in other else base[key]

    return {key: val(key) for key in {*base.keys(), *other.keys()}}
