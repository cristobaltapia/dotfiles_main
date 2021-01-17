#!/usr/bin/env bash
# pass get - Password Store Extension (https://www.passwordstore.org/)
# Copyright (C) 2020 James Patrick
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

R='\033[0;31m' 
G='\033[0;32m' 
NC='\033[0m'

PASSWORD_STORE_DIR="${PASSWORD_STORE_DIR:-$HOME/.password-store}"

cmd_get_usage() {
    cat <<-_EOF
Usage:
    $PROGRAM get pattern pass_name
        Parses the pass data for lines pulling out the value of browserpass's
        format of "key:value". The 'pattern' arg is a case insenitive, extended
        regex using grep -iE.

        https://github.com/browserpass/browserpass-extension

    Options:
        Nada.
_EOF
    exit 0
}


cmd_get_assert(){
    test="$1"
    local pattern="$2" expected="$3"

    actual="$(cmd_get "$pattern")"
    if [[ "$actual" == "$expected" ]] ; then
        echo -e "$G ✔  '$actual' ==  '$expected' $NC"
    else
        echo -e "$R ✘  f('$test', '$pattern') → '$actual' !=  '$expected' $NC"
    fi
}

cmd_get_test(){
    cmd_get_assert "username:value" "(user|username|login)" "value"
    cmd_get_assert " user: whitespace" "(user|username|login)" "whitespace"

   val="multiple:lines
value:pairs"
    cmd_get_assert "$val" "value" "pairs"
    cmd_get_assert "Key:capitalization doesn't counts" "key" \
        "capitalization doesn't counts"
    cmd_get_assert "missing:empty" "i don't exist" ""


    exit 0
}

cmd_get(){
    local pattern="$1" pass_name="$2"

    # valid the regex is valid
    echo | grep -qiE "$pattern"
    if [[ "$?" == 2 ]] ; then
        >&2 echo -e "${R}Invalid Pattern:${NC} $pattern"
        return 1
    fi 
    
    echo "${test:-$(cmd_show "$pass_name")}" \
        | grep -iE "$pattern" \
        | head -1 \
        | cut -d ':' -f2- \
        | sed -e 's/^[ \t]*//'
}


[[ "$1" == "test" ]] && cmd_get_test
[[ "$1" == "help" || "$1" == "--help" || "$1" == "-h" ]] && cmd_get_usage
[[ "$#" != "2" ]] && cmd_get_usage
cmd_get "$@"


