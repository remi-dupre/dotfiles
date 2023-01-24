#!/usr/bin/env python3
import sys
import time
import urllib.request


TARGET_URL = "https://www.qwant.com"
DELAY = 1


if __name__ == "__main__":
    while True:
        try:
            print("Waiting for internet...", file=sys.stderr, end="")

            with urllib.request.urlopen(TARGET_URL, timeout=1):
                print(" ok", file=sys.stderr)
                break
        except urllib.request.URLError as err:
            print(f" {err}", file=sys.stderr)
            time.sleep(DELAY)
