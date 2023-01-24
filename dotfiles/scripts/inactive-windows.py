#!/usr/bin/env python3

"""


See https://github.com/swaywm/sway/blob/master/contrib/inactive-windows-transparency.py
"""

import i3ipc


class App:
    TRANSPARENCY = "0.95"

    def __init__(self):
        self.ipc = i3ipc.Connection()
        self.prev_focused = None
        self.prev_workspace = self.ipc.get_tree().find_focused().workspace().num

        for window in self.ipc.get_tree():
            if window.focused:
                self.prev_focused = window
            else:
                window.command("opacity " + self.TRANSPARENCY)

    def on_focus(self, ipc, event):
        focused = event.container
        workspace = self.ipc.get_tree().find_focused().workspace().num

        if (
            focused.id != self.prev_focused.id
        ):  # https://github.com/swaywm/sway/issues/2859
            focused.command("opacity 1")

            if workspace == self.prev_workspace:
                self.prev_focused.command("opacity " + self.TRANSPARENCY)

            self.prev_focused = focused
            self.prev_workspace = workspace

    def daemon(self):
        self.ipc.on("window::focus", self.on_focus)
        self.ipc.main()


App().daemon()
