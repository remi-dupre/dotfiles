from enum import Enum


class Style(Enum):
    UNCHANGED = "\033[02m"
    CHANGED = "\033[0m\033[94m"
    RESET = "\033[0m"

    def print(self, *args, **kwargs):
        print(self.value, end="")
        print(*args, **kwargs, end="")
        print(self.RESET.value)
