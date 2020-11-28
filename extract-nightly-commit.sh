#!/bin/sh

set -e

grep -e "^ENV ECL_COMMIT" nightly/buster/Dockerfile | cut -d" " -f 3
