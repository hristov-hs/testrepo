import requests
import re


test_json = {
  "action": "opened",
  "number": 1,
    "input": {
        "body": {
            "pull_request": {
                "url": "https://api.github.com/repos/hristov-hs/testrepo/pulls/2",
                "id": 34585,
                "node_id": "MDExOlB1bGxSZXF1ZXN0MzQ1ODU=",
                "html_url": "https://github.com/hristov-hs/testrepo/pull/2",
                "diff_url": "https://github.com/hristov-hs/testrepo/pull/3.diff"
            }
        },
    },
}


def diff_url(event):
    """
    Aims to return git diff url from webhook.

    Keyword arguments:
        event -- (Dict) git event data
        return -- (String) git diff url for pull request
    """
    return event["input"]["body"]["pull_request"]["diff_url"]

def get_diff(url):
    """
    Requests URL and returns txt response
    Keyword arguments:
        url -- (String) GET request url
        return -- (String) response of GET request
    """
    response = requests.get(url)
    return response.text

def get_cb_name(event):
    """
    Extracts from 'git diff' response the CodeBuild names which have updated files.
    Keyword Arguments:
        git_diff -- (String) Text to extract CodeBuild name from
        line_start_string --- (String) String used to match starting of new line
        cb_names -- (List) All CodeBuild projects updated
    Returns:
        Type (Set) of names
    """
    cb_name = []
    line_start_regex = "^\+\+\+ b\/.*"
    name_prefix = "infra_image_factory"

    url = diff_url(event)
    git_diff = get_diff(url)
    updates = re.findall(rf'{line_start_regex}', git_diff, re.MULTILINE)
    for update in updates:
        dir_list = update.split('/')
        my_list = [item for item in dir_list if item.startswith(name_prefix)]
        cb_name.extend(my_list)
    return set(cb_name)

asd = get_cb_name(test_json)
print(len(asd))

