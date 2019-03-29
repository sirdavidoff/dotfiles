import sys
import subprocess
from workflow import Workflow

commands = [
                {
                    "title":"No special DNS",
                    "subtitle":"",
                    "check":"There aren't any DNS Servers set on Wi-Fi.",
                    "arg":"Empty"
                },
                {
                    "title":"Getflix Frankfurt DNS",
                    "subtitle":"54.93.169.181",
                    "check":"54.93.169.181",
                    "arg":"54.93.169.181"
                },
                {
                    "title":"Getflix Copenhagen DNS",
                    "subtitle":"82.103.129.240",
                    "check":"82.103.129.240",
                    "arg":"82.103.129.240"
                },
                {
                    "title":"Getflix Sao Paulo DNS",
                    "subtitle":"54.94.175.250",
                    "check":"54.94.175.250",
                    "arg":"54.94.175.250"
                }
            ]


def main(wf):

    global commands

    # Work out what DNS is set at the moment and add it as the first result
    current = subprocess.check_output(["networksetup", "-getdnsservers", "Wi-Fi"]).strip()
    matching_commands = [x for x in commands if x['check'] == current]
    current_cmd = None
    if len(matching_commands) > 0:
        current_cmd = matching_commands[0]
        wf.add_item(title=current_cmd['title'],
                    subtitle=current_cmd['subtitle'],
                    arg=current_cmd['arg'],
                    icon="icon_selected.png",
                    valid=True)

    # Add the rest of the results
    for cmd in commands:
        if cmd != current_cmd:
            wf.add_item(title=cmd['title'],
                        subtitle=cmd['subtitle'],
                        arg=cmd['arg'],
                        valid=True)

    # Send the results to Alfred as XML
    wf.send_feedback()


if __name__ == u"__main__":
    wf = Workflow()
    sys.exit(wf.run(main))
