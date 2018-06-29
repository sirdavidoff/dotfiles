import sys
import urllib2
from lxml import html, etree
from workflow import Workflow

# Could also show plurals, but this info is usually redundant because the
# singular version is also returned
types = {'m':'der', 'f':'die', 'nt':'das'}
max_results = 5

url = "https://www.linguee.com/english-german/search?qe={}&source=german&cw=581&ch=979&as=shownOnStart"
f = "/Users/david/Downloads/words.xml"

def main(query):

    global url, max_results

    wf = Workflow()
    num_results = 0

    # Not really sure what's going on with encodings here, but more info at
    # http://alfredworkflow.readthedocs.io/en/latest/user-manual/text-encoding.html
    query_encoded = wf.decode(query).encode('utf-8')
    url = url.format(urllib2.quote(query_encoded))

    code = urllib2.urlopen(url)
    tree = html.parse(code)
    # print etree.tostring(tree, pretty_print=True)
    # Get rid of the <spans> because they mess up getting the full 
    # text of the <div class="translation_item"> nodes
    etree.strip_elements(tree, "span", with_tail=False)
    elems = tree.xpath("//div[@class='main_item']")


    for e in elems:
        word = e.text

        # Get the word type
        next_elem = e.getnext()
        ty = None
        if next_elem is not None:
            ty = next_elem.text

        # Get the translations
        trans_node = e.getparent().getnext()
        translations = []
        if trans_node is not None:
            trans_nodes = trans_node.xpath(".//div[@class='translation_item']")
            translations = [''.join(i.text).strip() for i in trans_nodes]

        # Add the word to the list (if it's a relevant one)
        # We ignore words with spaces in them or that aren't one of the types above
        if " " not in word and ty in types.keys() and num_results < max_results:
            wf.add_item(title=word + " (" + types[ty] + ")",
                    subtitle=", ".join(translations),
                    icon="images/{}.png".format(ty),
                    valid=True)
            num_results += 1

    wf.send_feedback()

if __name__ == u"__main__":
    if len(sys.argv) < 2:
        print "Please provide a german word to look up"
        exit();
    main(sys.argv[1])
