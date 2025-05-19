#!/usr/bin/env python3

from datetime import datetime, timedelta
import json
import os
import requests
import sys
import time

ECHIDNA_ID_FILE = 'WD-echidna-id.txt'
ECHIDNA_STATUS_URL = 'http://labs.w3.org/echidna/api/status?id='


def get_echidna_id(directory):
    id_file = os.path.join(directory, ECHIDNA_ID_FILE)
    file_time = os.path.getmtime(id_file)
    if datetime.fromtimestamp(file_time) < datetime.now() - timedelta(hours=1):
        print(f'Warning: Echidna ID is not recent: timestamp is {file_time}')
    with open(id_file, 'r') as f:
        return f.read().strip()


def get_current_response(echidna_id):
    url = ECHIDNA_STATUS_URL + echidna_id
    print(f'Fetching {url}')
    tries = 3
    while tries:
        response = requests.get(url, allow_redirects=True)
        if response.status_code == 200:
            return response.json()

        print(f'Got status code {response.status_code}, text:')
        print(response.text)
        tries -= 1
        if tries:
            print('Retrying in 5s')
            time.sleep(5)

    raise Exception('Failed to fetch echidna result')



def get_echidna_result(echidna_id):
    response = get_current_response(echidna_id)
    while response['results']['status'] == 'started':
        time.sleep(5)
        print('Echidna run in progress, retrying...')
        response = get_current_response(echidna_id)

    result = response['results']['status']
    print(f'Echidna issue {echidna_id} is {result}.')
    print(json.dumps(response, indent=2))
    if result != 'success':
        raise Exception(f'Echidna result: {result}')


def main(argv):
    directory = os.getcwd() if len(argv) < 2 else argv[1]
    echidna_id = get_echidna_id(directory)
    print(f'Got echidna id {echidna_id}.')
    time.sleep(5)
    try:
        get_echidna_result(echidna_id)
    except Exception as e:
        print(f'Echidna failure: {e}')
        sys.exit(1)


if __name__ == '__main__':
    main(sys.argv)
