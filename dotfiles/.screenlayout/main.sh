#!/bin/sh
xrandr --output {{ monitor.name }} --primary --mode {{ monitor.width }}x{{ monitor.height }}
