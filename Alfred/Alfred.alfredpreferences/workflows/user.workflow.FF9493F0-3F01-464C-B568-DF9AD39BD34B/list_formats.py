#!/usr/bin/python

import sys
import subprocess
from collections import OrderedDict
from workflow import Workflow

formats = [
    {'name': 'autoformat', 'code': 'a'},
    {'name': 'calc', 'code': 'c'},
    {'name': 'euro', 'code': 'e'},
    {'name': 'general', 'code': 'g'},
    {'name': 'input', 'code': 'i'},
    {'name': 'label', 'code': 'l'},
    {'name': 'link', 'code': 'k'},
    {'name': 'percent', 'code': 'p'},
    {'name': 'plain', 'code': 'x'},
    {'name': 'dollar', 'code': 'd'},
    {'name': 'header', 'code': 'h'},
    {'name': 'output', 'code': 'o'},
    {'name': 'comment', 'code': 'm'},
    {'name': 'legend', 'code': 'g'},
]

def main(wf):

    if len(sys.argv) > 1:
        query = sys.argv[1]
        # print "query is " + query

        # Find the formats where the code matches 
        code_matches = filter(lambda x: x['code'].startswith(query), formats)

        # Find the formats where the name matches
        name_matches = filter(lambda x: x['name'].startswith(query), formats)

        # Concatenate the lists with code matches first and remove duplicates
        matches_with_dupes = (code_matches + name_matches)
        matches = []
        for i in matches_with_dupes:
            if i not in matches:
                matches.append(i)

    else:
        matches = formats
        
    for match in matches:
        wf.add_item(
            title=match['name'].title() + " style",
            subtitle="Code: " + match['code'],
            arg=match['name'],
            uid=match['name'],
            valid=True
        )

    wf.send_feedback()

if __name__ == u"__main__":
    wf = Workflow()
    sys.exit(wf.run(main))

