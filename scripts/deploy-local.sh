#!/usr/bin/env bash

SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
REPODIR="$(dirname "$SCRIPTDIR")"
cd "$REPODIR"

# always fail script if a cmd fails
set -eo pipefail

need_env_msg="
    
    You must have your World of Warcraft directory set.

    Example:
    export WOW_DIR=\"/c/Program Files/Blizzard/World of Warcraft/\"

    (Make sure to enclose in quotes as the directory path will have spaces)
"

[ -n "$WOW_DIR" ] || { printf "WOW_DIR is required and not set.\n$need_env_msg" >&2; exit 1; }

addons_dir="$WOW_DIR/_classic_/Interface/AddOns"
install_dir="$addons_dir/MageVendor"

echo "
Using these paths for install:

  WoW Directory         $WOW_DIR
  Addons Directory      $addons_dir
  Install Directory     $install_dir

"

if [ ! -d "$WOW_DIR" ]; then
    echo "Invalid WOW_DIR"
    exit 1
fi

if [ ! -d "$addons_dir" ]; then
    echo "Invalid Addons DIR, could be the result of an invalid WOW_DIR"
    exit 1
fi

if [ -d "$install_dir" ]; then
    echo "Cleaning up existing install..."
    rm -rf "$install_dir"
fi

mkdir -p "$install_dir"
cp src/* "$install_dir"

echo "Completed."