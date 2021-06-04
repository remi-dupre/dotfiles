#!/bin/sh
xrandr --listmonitors 2>&1 >> /tmp/.screenlayout.log
xrandr --output {{ monitor.name }} --mode {{ monitor.width }}x{{ monitor.height }}
xrandr --listmonitors 2>&1 >> /tmp/.screenlayout.log
