import sys
from recurrent import RecurringEvent
import json
from datetime import datetime, timedelta
import pytz
from tzlocal import get_localzone # $ pip install tzlocal
import re

# The hour of day to set the reminder for, if a date is specified but a time isn't
default_hour = 9

# Things to expand in the query string
substitutions = {'tom': 'tomorrow'}

# Words to ignore if they come between the date and the action
join_words = {
    'back': ['to'],
    'front':  ['at', 'on', 'in']
}

def parse_event(query):
    """
    Takes a free text string and splits it up into an action and
    an (optional) date. Returns the output in a format parsable by
    an Alfred script filter
    """

    words = query.split(" ")

    # Perform any substitutions listed above
    for i in xrange(len(words)):
        for key, val in substitutions.iteritems():
            if words[i] == key: words[i] = val
    query = " ".join(words)

    # Work out what date (if any) is contained in the query
    r = RecurringEvent()
    date = r.parse(query)

    if date is None: 
        alfred_output(query)
        return

    # Try to split the query into a date and an action, generating the point in the
    # sentence where the split should happen
    # Do this by taking words off the query one-by-one until the parsed date changes
    # The date can either be at the beginning or end of the query, so 
    # first try taking words off the back, then try taking words off the front
    # Keep the results of whichever method produces the longest action string
    # If the action string starts/ends in any of the join_words, take them off

    # Move backwards through the string (expects the date to be at the start)
    split_pos_back = len(words)-1
    while split_pos_back > 0 and r.parse(" ".join(words[0:split_pos_back])) == date:
        split_pos_back -= 1

    # Move forwards through the string (expects the date to be at the end)
    split_pos_front = 1
    while split_pos_front <= len(words) and r.parse(" ".join(words[split_pos_front:])) == date:
        split_pos_front += 1

    if split_pos_front > len(words) - split_pos_back:
        # The action is at the back of the query - use 'front'
        if split_pos_front > 2 and words[split_pos_front-2] in join_words['front']:
            split_pos_front -= 1
        action = " ".join(words[0:split_pos_front-1])
    else:
        # The action is at the front of the query - use 'back'
        if split_pos_back < len(words)-2 and words[split_pos_back+1] in join_words['back']:
            split_pos_back += 1
        action = " ".join(words[split_pos_back+1:])

    # Add in the timezone
    date = get_localzone().localize(date)

    # If we didn't specify a time, use the default one
    if not contains_time(query): date = date.replace(hour=default_hour, minute=0, second=0)

    # If the date is today but for a time that's already passed, add a day
    # to it so it's tomorrow
    now = datetime.now(get_localzone())
    if date < now:
        # Date is in the past
        diff = date.date() - now.date()
        if diff.days == 0:
            date = date + timedelta(days=1)

    alfred_output(action, date)


def alfred_output(action, date=None):
    """
    Outputs the reminder in a format that an Alfred
    script filter can understand
    """

    action_readable = action[0].upper() + action[1:] if len(action) > 0 else ''

    output = {'items':
        [{
            'title':"Set reminder to '{}'".format(action),
            'arg':{
                'text':action_readable
            }
        }]
    }

    if date is not None:
        output['items'][0]['subtitle'] = humanised_date(date)
        output['items'][0]['arg']['date'] = date.isoformat()

    # If 'arg' is an object then Alfred has problems passing it properly.
    output['items'][0]['arg'] = json.dumps(output['items'][0]['arg'])

    print json.dumps(output)


def contains_time(string):
    """
    Returns true if the passed string contains a time 
    Detects times like 1pm and 13:00
    """
    giveaways = [r'\d ?am', r'\d ?pm', r'\d:\d\d'] 
    return any([re.search(t, string) is not None for t in giveaways])


def humanised_date(then):
    " Returns a compact, readable version of the date "

    if then is None: return None
    now = datetime.now(get_localzone())
    diff = then.date() - now.date()
    if diff.days == 0:
        return then.strftime("Today, %H:%M")
    elif diff.days == 1:
        return then.strftime("Tomorrow, %H:%M")
    elif diff.days < 6:
        return then.strftime("%a, %H:%M")
    elif then.year == now.year and then.month == now.month:
        return then.strftime("%a {d}, %H:%M").replace('{d}', str(then.day)+suffix(then.day))
    elif then.year == now.year:
        return then.strftime("%a {d} %b, %H:%M").replace('{d}', str(then.day)+suffix(then.day))
    else:
        return then.strftime("%a {d} %b %Y, %H:%M").replace('{d}', str(then.day)+suffix(then.day))


def suffix(d):
    " Returns the correct ordinal to use with a number "
    return 'th' if 11<=d<=13 else {1:'st',2:'nd',3:'rd'}.get(d%10, 'th')


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Please supply the event string to be parsed as an argument")
    else:
        parse_event(sys.argv[1])

