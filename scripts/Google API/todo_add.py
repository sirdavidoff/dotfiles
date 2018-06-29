
# To install, follow instructions here:
# https://developers.google.com/apps-script/guides/rest/quickstart/python
# Make sure that you:
# - Enable both the apps script API AND the drive API
# - Create a WEB OAuth token (with the right origin and redirect settings) (although an 'other' token might also be OK)
# - Update APPLICATION_NAME below to be the same as the name of your client ID from the token
# - Update the SCOPES below to include everything you find in File -> Project properties -> Scopes in the Script Editor 
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

# You can find out the scopes you script uses by going to
# File -> Project properties -> Scopes in the Script Editor
# If modifying these scopes, delete your previously saved credentials
SCOPES = ['https://www.googleapis.com/auth/documents', 'https://www.googleapis.com/auth/script.container.ui']
CREDENTIALS_FILE = 'todo_add_credentials_other.json'
CLIENT_SECRET_FILE = 'client_secret_todo.json'
APPLICATION_NAME = 'Todo add script'
# This is the ID of the script that we want to run (not the doc it acts on)
SCRIPT_ID = 'M4CP4VlCLiMXot8vw2N4VXhO8kIdkNjLe'


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

    if len(sys.argv) < 2:
        print("Please supply the task as an argument")
        return

    task = sys.argv[1]
    task = task[0].upper() + task[1:] # Capitalise first letter

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
