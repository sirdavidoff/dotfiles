#!/usr/bin/python

import gdata.docs.service
import gdata.photos.service
import gdata.media
#import gdata.geo

from datetime import datetime, timedelta
from oauth2client.client import flow_from_clientsecrets
from oauth2client.file import Storage
import webbrowser
import sys
import subprocess
import httplib2
import pprint

dst_dir = '/Users/david/Downloads'
client_secrets = 'client_id.json'
credential_store = 'credentials.dat'
email = 'david@thedavid.co.uk'

def OAuth2Login(client_secrets, credential_store, email):
    scope='https://picasaweb.google.com/data/'
    user_agent='myapp'

    storage = Storage(credential_store)
    credentials = storage.get()
    if credentials is None or credentials.invalid:
        flow = flow_from_clientsecrets(client_secrets, scope=scope, redirect_uri='urn:ietf:wg:oauth:2.0:oob')
        uri = flow.step1_get_authorize_url()
        webbrowser.open(uri)
        code = raw_input('Enter the authentication code: ').strip()
        credentials = flow.step2_exchange(code)
        storage.put(credentials)

    if (credentials.token_expiry - datetime.utcnow()) < timedelta(minutes=5):
        http = httplib2.Http()
        http = credentials.authorize(http)
        credentials.refresh(http)

    gd_client = gdata.photos.service.PhotosService(source=user_agent,
                                               email=email,
                                               additional_headers={'Authorization' : 'Bearer %s' % credentials.access_token})

    return gd_client



gd_client = OAuth2Login(client_secrets, credential_store, email)

photos = gd_client.GetUserFeed(kind='photo', limit='1')
for photo in photos.entry:
    #print 'Recently added photo title:', photo.title.text
    pp = pprint.PrettyPrinter()
    pp.pprint(photo)
    exit()
    print photo.GetMediaURL()
    media = gd_client.GetMedia(photo.GetMediaURL())

    #print media.file_name, media.content_type, media.content_length
    data = media.file_handle.read()
    media.file_handle.close()

    filename = "%s/%s" % (dst_dir, photo.title.text)
    sys.stdout.flush()

    #if not os.path.isdir(aname):
        #os.mkdir(aname)

    out = open(filename, 'wb')
    out.write(data)
    out.close()

    subprocess.call(['open', dst_dir])

