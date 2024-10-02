#!/usr/bin/env python3

from datetime import datetime, timedelta
import os
import requests
import sys
import json

ECHIDNA_ID_FILE = 'WD-echidna-id.txt'


def get_echidna_id(directory):
    id_file = os.path.join(directory, ECHIDNA_ID_FILE)
    file_timestamp = os.path.getmtime(id_file)
    if datetime.fromtimestamp(file_timestamp) < datetime.now() - timedelta(hours=1):
        print(f'Warning: timestamp is {file_timestamp}')
    with open(id_file, 'r') as f:
        return f.read().strip()


def get_echidna_result(echidna_id):
    url = f'http://labs.w3.org/echidna/api/status?id={echidna_id}'
    response = requests.get(url, allow_redirects=True)
    if response.status_code != 200:
        print(f'Got status code {response.status_code}, text:')
        print(response.text)
        raise Exception('Failed to fetch')
    
    data = response.json()
    result = data["results"]["status"]
    print(f'Echidna issue {echidna_id} is {result}.')
    print(json.dumps(data['results'], indent=2))
    return result == "success"


def main(argv):
    if len(argv) == 1:
        directory = os.getcwd()
    else:
        directory = argv[1]
    echidna_id = get_echidna_id(directory)
    print(f'Got echidna result id {echidna_id}.')
    if not get_echidna_result(echidna_id):
        sys.exit(1)


if __name__ == '__main__':
    main(sys.argv)
