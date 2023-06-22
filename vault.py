#!/bin/env python

import argparse
import json
import pathlib
import sys
import tomllib


def error(msg: str) -> None:
    print(msg, file=sys.stderr)
    sys.exit(1)


parser = argparse.ArgumentParser()
parser.add_argument('vault', type=pathlib.Path)
parser.add_argument('key', type=str, nargs='?')
parser.add_argument('--json', '-j', action='store_true')

args = parser.parse_args()

with args.vault.expanduser().open('rb') as f:
    data = tomllib.load(f)

try:
    if args.key:
        for part in args.key.split('.'):
            data = data[part]
except KeyError:
    error(f"key '{args.key}' not found in vault")

if args.json:
    data = json.dumps(data)
elif not isinstance(data, str):
    error('data is not a string, please use -j/--json')

print(data, end='')
