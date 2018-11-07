# To set up:
#  - Turn on Google Caldendar API and download client secret .json (as client_secret_calendar.json) by visiting:
#    https://console.developers.google.com/start/api?id=calendar
#  - Install pip if not already (sudo easy_install pip)
#  - pip install --upgrade google-api-python-client --user
#  - pip install pyperclip --user
#  - Run this script
#  - If you get an error about Six, add this line to your profile:
#    export PYTHONPATH=/Library/Python/2.7/site-packages
# Full instructions here:
# https://developers.google.com/google-apps/calendar/quickstart/python

from __future__ import print_function
import httplib2
import os
import sys
import time

from apiclient import discovery
from oauth2client import client
from oauth2client import tools
from oauth2client.file import Storage

from datetime import datetime, timedelta
import dateutil.parser
from dateutil import tz
import pytz
import pyperclip

# If modifying these scopes, delete your previously saved credentials
# at ~/.credentials/CREDENTIALS_FILE
SCOPES = 'https://www.googleapis.com/auth/calendar'
CREDENTIALS_FILE = 'calendar.json'
CLIENT_SECRET_FILE = 'client_secret_calendar.json'
APPLICATION_NAME = 'Google Calendar Slot Options'


def get_credentials():
    """Gets valid user credentials from storage.

    If nothing has been stored, or if the stored credentials are invalid,
    the OAuth2 flow is completed to obtain the new credentials.

    Returns:
        Credentials, the obtained credential.
    """
    home_dir = os.path.expanduser('~')
    credential_dir = os.path.join(home_dir, '.credentials')
    if not os.path.exists(credential_dir):
        os.makedirs(credential_dir)
    credential_path = os.path.join(credential_dir, CREDENTIALS_FILE)

    store = Storage(credential_path)
    credentials = store.get()
    if not credentials or credentials.invalid:
        flow = client.flow_from_clientsecrets(CLIENT_SECRET_FILE, SCOPES)
        flow.user_agent = APPLICATION_NAME
        flags = tools.argparser.parse_args(args=[])
        credentials = tools.run_flow(flow, store, flags)
        print('Storing credentials to ' + credential_path)
    return credentials

def main():
    """Returns a list of the times of any events created recently with no title
    
       The name to assign to the events must be passed as a parameter, and you can 
       optionally pass a time zone to display the events in at the end, e.g.

       python calendar_slot_options.py "Event name goes here BST"
    """

    if len(sys.argv) < 2:
        print("Please supply the name of the event as an argument")
        return

    # Work out the event title and time zone from the arguments
    timezones = {'CET': 'Europe/Berlin',
                 'CEST':'Europe/Berlin',
                 'GMT':'Europe/London',
                 'BST':'Europe/London',
                 'ET':'US/Eastern',
                 'CT':'US/Central',
                 'MT':'US/Mountain',
                 'PT':'US/Pacific'}
    timezone = sys.argv[1].split()[-1]
    if timezone in timezones:
        zone = timezones[timezone]
        summary = sys.argv[1].rsplit(" ", 1)[0]
    else:
        zone = 'Europe/Berlin'
        summary = sys.argv[1]

    # print(summary) 
    # print(zone) 

    credentials = get_credentials()
    http = credentials.authorize(httplib2.Http())
    service = discovery.build('calendar', 'v3', http=http)

    # Get all events that have been updated in the last 15 mins
    cutoff_time = datetime.now(tz.tzlocal()) - timedelta(minutes=15)
    eventsResult = service.events().list(
        calendarId='primary', updatedMin=cutoff_time.isoformat(), maxResults=100, singleEvents=True,
        orderBy='updated').execute()
    events = eventsResult.get('items', [])

    # Filter the events to only include unnamed ones that aren't cancelled
    events = [e for e in events if 'summary' not in e and e['status'] != 'cancelled']
    if not events:
        os.system("""osascript -e 'display notification "Make sure you've created empty ones" with title "Couldn't find events"'""")
        print("Couldn't find events")
        return

    # Sort the events by start date
    events = sorted(events, key=lambda k: k['start']['dateTime'])

    # Work out if all the events are in the current month
    # If so, we can leave out the month when describing them
    this_month = datetime.now().strftime("%m")
    single_month = [e for e in events if e['start']['dateTime'][5:7] != this_month] == []

    output = ""
    for event in events:
        # Convert dates to the desired time zone
        event_start = dateutil.parser.parse(event['start']['dateTime'])
        event_end = dateutil.parser.parse(event['end']['dateTime'])
        event_start_local = event_start.astimezone(pytz.timezone(zone))
        event_end_local = event_end.astimezone(pytz.timezone(zone))

        # Format the string for the event time
        if event_start_local.date() == datetime.today().date():
            date_string = "Today"
        elif event_start_local.date() == datetime.today().date() + timedelta(1):
            date_string = "Tomorrow (%a)"
        elif single_month:
            date_string = "%a %d"
        else:
            date_string = "%a %d %b"
        output += event_start_local.strftime("- {} from %H:%M-".format(date_string)) + event_end_local.strftime("%H:%M (%Z)") + "\n"

        # Set the name of the event and the colour to gray
        event['summary'] = "HOLD OPT: " + summary
        event['colorId'] = "8"
        updated_event = service.events().update(calendarId='primary', eventId=event['id'], body=event).execute()

    os.system("""osascript -e 'display notification "{}" with title "{} events updated"'""".format(summary, len(events)))
    pyperclip.copy(output)
    print(output)
    



if __name__ == '__main__':
    main()
