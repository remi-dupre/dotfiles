#!/usr/bin/env python3
"""
Display information about closest Velib' station.

Usage: ./velib-station.py <station-id 1> <station-id 2> ...
"""
import asyncio
import sys
from typing import Tuple

import httpx
from geopy.distance import geodesic


IPINFO_URL = "https://ipinfo.io/json"
STATIONS_URL = "https://velib-metropole-opendata.smoove.pro/opendata/Velib_Metropole/station_information.json"
STATUS_URL = "https://velib-metropole-opendata.smoove.pro/opendata/Velib_Metropole/station_status.json"


async def main():
    async with httpx.AsyncClient(timeout=None) as http:
        loc, status, stations = await asyncio.gather(
            http.get(IPINFO_URL),
            http.get(STATUS_URL),
            http.get(STATIONS_URL),
        )

        loc.raise_for_status()
        status.raise_for_status()
        stations.raise_for_status()

    loc = loc.json()
    stations = {s["station_id"]: s for s in stations.json()["data"]["stations"]}

    lat, lon = map(float, loc["loc"].split(","))

    station = min(
        (s for s in stations.values() if s["stationCode"] in sys.argv[1:]),
        key=lambda s: geodesic((lat, lon), (s["lat"], s["lon"])),
    )

    status = next(
        s
        for s in status.json()["data"]["stations"]
        if s["station_id"] == station["station_id"]
    )

    print(f"Found location in {loc['city']}", file=sys.stderr)
    print(f"Closest selected station is {station['name']}", file=sys.stderr)
    print(
        f"{status['num_bikes_available_types'][0]['mechanical']}M "
        f"{status['num_bikes_available_types'][1]['ebike']}E "
        f"{status['num_docks_available']}L"
    )


if __name__ == "__main__":
    asyncio.run(main())
