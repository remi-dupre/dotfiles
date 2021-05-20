#!/usr/bin/env python3
import sys
import time
import urllib.request


TARGET_URL = "https://perdu.com"
DELAY = 1


if __name__ == "__main__":
    while True:
        try:
            response = urllib.request.urlopen(TARGET_URL, timeout=1)
            break
        except urllib.request.URLError:
            print("Waiting for internet...", file=sys.stderr)
            time.sleep(DELAY)
