#!/usr/bin/python

import sys
import subprocess
from workflow import Workflow


def main(wf):
    # Work out which app is currently frontmost, so it's not displayed in the list
    frontmost_app = subprocess.check_output("osascript -e 'tell application \"System Events\" to name of first application process whose frontmost is true'", shell=True).rstrip()

    # Get the list of running apps using Actionscript
    out = subprocess.check_output("osascript -e 'tell application \"System Events\" to get name of (processes where background only is false)'", shell=True)

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
