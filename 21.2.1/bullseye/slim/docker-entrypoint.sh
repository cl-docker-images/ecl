#!/bin/sh

# If the first arg starts with a hyphen, prepend ecl to arguments.
if [ "${1#-}" != "$1" ]; then
	set -- ecl "$@"
fi

exec "$@"
