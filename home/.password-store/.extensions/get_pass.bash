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


PASSWORD_STORE_DIR="${PASSWORD_STORE_DIR:-$HOME/.password-store}"

cmd_get_pass_usage() {
    cat <<-_EOF
Usage:
    $PROGRAM get_pass pass_name
        Grabs the pass based on rules for Browserpass.
          1. match "key:value" where key, either pass, password, or secret
          2. if no match is present default to the first line.

        https://github.com/browserpass/browserpass-extension

    Options:
        Nada.
_EOF
    exit 0
}


cmd_get_user(){
    local pass_name="$1" val backup
    val=$(pass get "(pass|password|secret)" "$pass_name")
    backup=$(cmd_show "$pass_name" | head -1) 
    echo "${val:-$backup}"
}

[[ "$1" == "help" || "$1" == "--help" || "$1" == "-h" ]] && cmd_get_user_usage
[[ "$#" != "1" ]] && cmd_get_user_usage
cmd_get_user "$@"


