
# To install, follow instructions here:
# https://developers.google.com/apps-script/guides/rest/quickstart/python
# Make sure that you:
# - Enable both the apps script API and the drive API
# - Create a WEB OAuth token (with the right origin and redirect settings)
# - Update SCRIPT_ID below to refer to the Apps Script you want to run
# You also need to publish the script as an API executable using the 'publish' menu of the script edit

# NB: To install dependencies, run
# pip install --upgrade google-api-python-client --user

from __future__ import print_function
import httplib2
import os
import sys

from apiclient import discovery
from oauth2client import client
from oauth2client import tools
from oauth2client.file import Storage

from apiclient import errors

# try:
    # import argparse
    # flags = argparse.ArgumentParser(parents=[tools.argparser]).parse_args()
# except ImportError:
    # flags = None

# If modifying these scopes, delete your previously saved credentials
# at ~/.credentials/script-python-quickstart.json
SCOPES = 'https://www.googleapis.com/auth/documents'
CLIENT_SECRET_FILE = 'client_secret_todo.json'
APPLICATION_NAME = 'Apps Script'


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
    credential_path = os.path.join(credential_dir,
                                   'script-python-quickstart.json')

    store = Storage(credential_path)
    credentials = store.get()
    if not credentials or credentials.invalid:
        flow = client.flow_from_clientsecrets(CLIENT_SECRET_FILE, SCOPES)
        flow.user_agent = APPLICATION_NAME
        # if flags:
        credentials = tools.run_flow(flow, store, flags)
        # else: # Needed only for compatibility with Python 2.6
            # credentials = tools.run(flow, store)
        print('Storing credentials to ' + credential_path)
    return credentials

def main():

    if len(sys.argv) < 2:
        print("Please supply the task as an argument")
        return

    task = sys.argv[1]
    task = task[0].upper() + task[1:] # Capitalise first letter

    SCRIPT_ID = 'M4CP4VlCLiMXot8vw2N4VXhO8kIdkNjLe'

    # Authorize and create a service object.
    credentials = get_credentials()
    http = credentials.authorize(httplib2.Http())
    service = discovery.build('script', 'v1', http=http)

    # Create an execution request object.
    request = {"function": "insertAtTopOf",
               "parameters": ["Todo", task]}

    try:
        # Make the API request.
        response = service.scripts().run(body=request,
                scriptId=SCRIPT_ID).execute()

        if 'error' in response:
            # The API executed, but the script returned an error.

            # Extract the first (and only) set of error details. The values of
            # this object are the script's 'errorMessage' and 'errorType', and
            # an list of stack trace elements.
            error = response['error']['details'][0]
            print("Script error message: {0}".format(error['errorMessage']))

            if 'scriptStackTraceElements' in error:
                # There may not be a stacktrace if the script didn't start
                # executing.
                print("Script error stacktrace:")
                for trace in error['scriptStackTraceElements']:
                    print("\t{0}: {1}".format(trace['function'],
                        trace['lineNumber']))
        else:
            print("Returned successfully")
            os.system("""osascript -e 'display notification "{}" with title "Task added"'""".format(task))

    except errors.HttpError as e:
        # The API encountered a problem before the script started executing.
        print(e.content)

if __name__ == '__main__':
    main()
