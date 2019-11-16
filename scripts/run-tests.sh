#!/usr/bin/env bash

SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
REPODIR="$(dirname "$SCRIPTDIR")"
cd "$REPODIR"

# always fail script if a cmd fails
set -eo pipefail

need_luarocks_msg="
    
    You must have the luarocks and busted cli tools installed for testing this repository.

    To install using apt-get: apt-get install luarocks

    Additional instructions found here: http://olivinelabs.com/busted/#usage

"
command -v luarocks >/dev/null 2>&1 || { printf "luarocks is required but not installed...\n$need_luarocks_msg" >&2; exit 1; }
command -v busted >/dev/null 2>&1 || { printf "busted is required but not installed...\n$need_luarocks_msg" >&2; exit 1; }

busted ./test -p _Tests