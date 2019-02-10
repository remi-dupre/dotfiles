#!/usr/bin/python3

import json
import subprocess
import sys


CMD_LIST_WS = ['i3-msg', '-t', 'get_workspaces']
CMD_SELECT_WS = ['i3-msg', 'workspace']


command = sys.argv[1]

ws_infos = json.loads(
    subprocess.Popen(CMD_LIST_WS, stdout=subprocess.PIPE).stdout.read()
)


# Compute workspace to select
for i in range(len(ws_infos)):
    if ws_infos[i]['focused']:
        selected_ws = i

if command == 'next':
    selected_ws = (selected_ws + 1) % len(ws_infos)
if command == 'prev':
    selected_ws = (selected_ws - 1) % len(ws_infos)

# Select computed workspace
subprocess.Popen(CMD_SELECT_WS + [ws_infos[selected_ws]['name']])

