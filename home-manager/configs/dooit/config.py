from dooit.ui.api import DooitAPI, subscribe
from dooit.ui.api.events import Startup
from dooit.ui.widgets.trees.base_tree import BaseTree


@subscribe(Startup)
def setup(api: DooitAPI, _):
    api.keys.set("o", api.add_child_node)
    api.keys.set("dd", api.remove_node)
    api.keys.set("q", api.quit)


def key_up(self):
    self.action_cursor_up()


def key_down(self):
    self.action_cursor_down()


BaseTree.key_up = key_up
BaseTree.key_down = key_down
