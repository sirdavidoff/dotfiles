#!/usr/bin/python

import sys
import subprocess
from workflow import Workflow
import json
import pdb

chrome_kw = 'chrome'

def main(wf):
    # Work out which app is currently frontmost, so it's not displayed in the list
    frontmost_app = subprocess.check_output("osascript -e 'tell application \"System Events\" to name of first application process whose frontmost is true'", shell=True).rstrip()

    # Get the list of running apps using Actionscript
    out = subprocess.check_output("osascript -e 'tell application \"System Events\" to get name of (processes where background only is false)'", shell=True)

    # If we've typed 'chrome', list the open tabs
    if len(sys.argv) > 1 and sys.argv[1].lower().startswith(chrome_kw):
        q = sys.argv[1].lower()[len(chrome_kw):].strip()
        tab_json = subprocess.check_output("osascript \"$DOTFILES/scripts/List Chrome tabs.scpt\"", shell=True)
        tabs = json.loads(tab_json)
        for i in tabs:
            # pdb.set_trace()
            elems = i[2].split(' ') + i[3].replace('/', '.').split('.')
            matches = filter(lambda x: x.lower().startswith(q), elems)
            if len(matches) > 0:
                icon_path = subprocess.check_output("osascript -e 'tell application \"Finder\" to POSIX path of (application file id (id of application \"Google Chrome\") as alias)'", shell=True)
                icon_path = icon_path.rstrip("/\n")
                wf.add_item(title=i[2], subtitle="Tile with frontmost application", arg="{},{}".format(i[0],i[1]), valid=True, icon=icon_path, icontype="fileicon")
    else:
        for app_name in out.rstrip().split(", "):
            # Check whether the name of the app matches what we've typed
            if(app_name != frontmost_app and (len(sys.argv) == 1 or app_name.lower().startswith(sys.argv[1].lower()))):
                # If so, add it to the output list
                icon_path = subprocess.check_output("osascript -e 'tell application \"Finder\" to POSIX path of (application file id (id of application \"{}\") as alias)'".format(app_name), shell=True)
                icon_path = icon_path.rstrip("/\n")
                # print(icon_path)
                wf.add_item(title=app_name, subtitle="Tile with frontmost application", arg=app_name, valid=True, icon=icon_path, icontype="fileicon")

    wf.send_feedback()

if __name__ == u"__main__":
    wf = Workflow()
    sys.exit(wf.run(main))
