# Adds a card to a Trello board
#
# Usage: 
#   python trello_add.py trello_key trello_token trello_board_id card_details
#
# card_details is a string in the format
#   card_name # description ; keywords
# (description and keywords are optional. Keywords can be names
# of labels to be added to the card, or the list to add the card to


import sys
import requests
import subprocess
from workflow import Workflow
import pprint as prettyprint
import json
from datetime import datetime
from os import path

debug = False
url = "https://api.trello.com/1"
board_data_path = "board_data.json"
cache_days = 1 # Number of days to wait before refreshing cache

param_map = {
    'label':{'name':'idLabels', 'is_list':True},
    'list':{'name':'idList', 'is_list':False},
    'board':{'name':'idBoard', 'is_list':False},
}

# Sample board data format:
# boards = {
    # 'board_id': {
        # 'name': "Locarta",
        # 'labels': {
            # 'red': '234223423',
            # 'orange': '23427892',
            # 'blue': '234i2343'
        # },
        # 'lists': {
            # 'inbox': '1',
            # 'projects': '2',
            # 'today': '3',
            # 'blocked': '4',
            # 'later': '5',
            # 'small: '6'
        # },
        # 'first_list_id': '1'
    # }
# }

def get_boards_info(key, token, force_query_api=False):
    """
    Reads in all the details of the boards (id, label names, lists, etc.)
    Tries to read from the local cache first, then falls back to querying the Trello API
    Can be forced to use the API with the 'force_query_api' parameter
    """

    global board_data_path, url
    boards = {}

    # Use locally cached version if it exists and isn't too old
    if path.exists(board_data_path) and not force_query_api:
        with open(board_data_path, 'r') as f:
            boards = json.load(f)
            for b in boards:
                # Manually decode the datetimes since the json module can't do this automatically
                boards[b]['lastUpdated'] = datetime.strptime(boards[b]['lastUpdated'], "%Y-%m-%d %H:%M:%S.%f")
            if len(boards) > 1 and (datetime.now() - boards[boards.keys()[0]]['lastUpdated']).days > cache_days:
                boards = {}
    
    # Otherwise fetch the latest info from the Trello API
    if len(boards) == 0:

        # Get the overall board data
        call = "{}/members/me/boards?key={}&token={}".format(url, key, token)
        r = requests.get(call)
        board_data = r.json()

        for b in board_data:
            if not b['closed']:
                boards[b['id']] = {
                    'name':b['name'],
                    'lastUpdated':datetime.now()
                }

        # Get the list names for each board
        if len(boards) > 0:
            calls = ["/boards/{}/lists".format(bid) for bid in boards.keys()]
            r = requests.get("{}/batch?urls={}&key={}&token={}".format(url, ",".join(calls), key, token))
            list_data = r.json()

            for b in list_data:
                if '200' in b and len(b['200']) > 0:
                    board_id = b['200'][0]['idBoard']
                    boards[board_id]['lists'] = {l['name']:l['id'] for l in b['200'] if not l['closed']}
                    boards[board_id]['first_list_id'] = b['200'][0]['id']

        # Get the labels for each board
        if len(boards) > 0:
            calls = ["/boards/{}/labels".format(bid) for bid in boards.keys()]
            r = requests.get("{}/batch?urls={}&key={}&token={}".format(url, ",".join(calls), key, token))
            label_data = r.json()

            for b in label_data:
                if '200' in b and len(b['200']) > 0:
                    board_id = b['200'][0]['idBoard']
                    names = {l['name']:l['id'] for l in b['200'] if l['name'] != ''}
                    colors = {l['color']:l['id'] for l in b['200']}
                    colors.update(names)
                    boards[board_id]['labels'] = colors

        # Cache the data to file
        with open(board_data_path, 'w') as outfile:
            json.dump(boards, outfile, indent=4, default=str)

    # pp = pprint.PrettyPrinter()
    # pp.pprint(boards)

    return boards


def match_keywords(keywords):
    """
    Returns a list of all the things each keyword could mean
    """

    global boards

    matches = []
    for keyword in keywords:
        for board_id, board in boards.iteritems():
            matches += match_details(board_id, 'board', keyword, {board['name']: board_id})
            matches += match_details(board_id, 'list', keyword, board['lists'])
            matches += match_details(board_id, 'label', keyword, board['labels'])

    # Sort the keywords
    # TODO: Is this sorting the right way?
    matches = sorted(matches, key=lambda x: x['accuracy'])

    return matches
    

def match_details(board_id, trello_type, keyword, options):
    """ 
    Given options, which is a dict of type {id: value}, checks whether the keyword
    matches the key or the value (at least partially). Then returns the best match in the form
    {keyword, board_id, type, id, accuracy, keyword}
    """

    keyword = keyword.lower()
    output = []
    for val, key in options.iteritems():
        # Determine whether the key or val is a match, and if both
        # do then which one is a better match
        chosen_opt = None
        if key[:len(keyword)].lower() == keyword: 
            chosen_opt = key
        if val[:len(keyword)].lower() == keyword and len(val) < len(key):
            chosen_opt = val

        if chosen_opt:
            output.append({
                'keyword':keyword,
                'board_id':board_id, 
                'type':trello_type, 
                'id':key, 
                'accuracy':len(keyword)/float(len(chosen_opt))
            })

    return output

def fit_to_board(keywords, matches, board_id, board_kw):
    """
    Returns the matches for all the keywords assuming we're using the passed board
    Returns None if we can't match everything
    """

    # The output will always have the match with the board
    # output = filter(matches, lambda: x: x['type'] == 'board' and x['id'] == board_id and x['keyword'] == board_kw)
    output = [{'keyword':board_kw, 'board_id':board_id, 'id':board_id, 'type':'board'}]

    # Take the keyword that matched the board out of the list of keywords
    keywords = filter(lambda x: x != board_kw, keywords)
    # Get rid of any matches not about this board or matching a board
    matches = filter(lambda x: x['board_id'] == board_id and x['type'] != 'board', matches)

    for kw in keywords:
        kw_matches = filter(lambda x: x['keyword'].lower() == kw.lower(), matches)
        if len(kw_matches) > 0:
            output.append(max(kw_matches, key=lambda x: x['accuracy']))

    return output


def optimal_matches(keywords, matches, default_board_id):
    """
    Works out which meaning to assign each keyword. Returns None if
    not all the keywords can be matched to the same board
    """

    board_matches = filter(lambda x: x['type'] == 'board', matches)

    added_board = False
    # Add in the default board if it's not there already
    if len(filter(lambda x: x['board_id'] == default_board_id, board_matches)) < 1:
        board_matches.append({
            'board_id':default_board_id,
            'type':'board',
            'id':default_board_id,
            'keyword':None
        })
        added_board = True


    #TODO: Here we only ever consider the most complete matches for each
    # keyword. Not the most intelligent approach, but we'd be getting into
    # a whole new level of complexity otherwise

    #TODO: Check not multiple lists
    for board in board_matches:
        config = fit_to_board(keywords, matches, board['id'], board['keyword'])
        # print "Here's the config"
        # print config
        # print added_board
        # print len(keywords)
        # print len(config)
        used_added_board = added_board and \
            len(filter(lambda x: x['board_id'] == default_board_id, config)) > 0
        if (not (used_added_board) and len(keywords) == len(config)) or \
           (used_added_board and len(keywords) == len(config)-1):
               return config

    return None

def error(msg):
    subprocess.call("osascript -e 'display dialog \""+msg+"\" buttons {\"OK\"} default button \"OK\"'", shell=True)
    exit()


def pprint(msg):
    global debug
    if(debug):
        pp = prettyprint.PrettyPrinter()
        pp.pprint(msg)


def main():

    global url, boards, param_map
    wf = Workflow()

    if len(sys.argv) < 5:
        error("Please specify the Trello key, token, board ID and card name (in that order)")

    data = {}
    data['key'] = sys.argv[1]
    data['token'] = sys.argv[2]
    data['default_board_id'] = sys.argv[3]
    sys.argv[4] = wf.args[3]

    boards = get_boards_info(data['key'], data['token'])

    # Look for a semicolon that separates the name from
    # the keywords
    semicolon_pos = sys.argv[4].find(";")
    if semicolon_pos == -1:
        data['name'] = sys.argv[4]
    else:
        data['name'] = sys.argv[4][0:semicolon_pos].strip()
        keywords = sys.argv[4][semicolon_pos+1:].strip().split(" ")
        keywords = map(unicode.strip, keywords)

        # Work out if we're trying to put the card at the top of the list
        if 'top' in keywords:
            data['pos'] = 1
            keywords.remove('top')

        matches = match_keywords(keywords)

        pprint("All matches")
        pprint(matches)

        # Work out what each keyword means
        final_matches = optimal_matches(keywords, matches, data['default_board_id'])

        pprint("Final matches")
        pprint(final_matches)

        if final_matches == None:
            error("There was a problem with your keywords")

        # Add the matches to the data for the POST request
        for m in final_matches:
            name = param_map[m['type']]['name']
            if param_map[m['type']]['is_list']:
                if not name in data: data[name] = []
                data[name].append(m['id'])
            else:
                data[name] = m['id']

    # Split the desc out of the name if there is one
    hash_pos = data['name'].find("#")
    if hash_pos != -1:
        data['desc'] = data['name'][hash_pos+1:].strip()
        data['name'] = data['name'][0:hash_pos].strip()

    # Fill in any missing data we didn't specify explicitly
    if not 'idBoard' in data:
        data['idBoard'] = data['default_board_id']
    if not 'idList' in data:
        data['idList'] = boards[data['idBoard']]['first_list_id']

    # Uppercase the first letter of the card name
    data['name'] = data['name'][0].upper() + data['name'][1:]

    # Create the card
    # pp.pprint(data)
    r = requests.post(url+"/cards", params={'key':data['key'], 'token':data['token']}, data=data)
    r.json()

    # Print a summary of exactly where the card was inserted
    board_name = boards[data['idBoard']]['name']
    lists = boards[data['idBoard']]['lists']
    list_name = lists.keys()[lists.values().index(data['idList'])]
    pos = "top" if 'pos' in data and data['pos'] == 1 else "end"
    print "Added to {} of {} > {}".format(pos.encode('utf-8'), board_name.encode('utf-8'), list_name.encode('utf-8'))

if __name__ == '__main__':
    main()

