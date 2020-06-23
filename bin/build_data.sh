#!/bin/bash
#
# Copyright (c) 2020 Ph.D. Hugo Gabriel Eyherabide
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
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

# \brief Generates test data

POSIXLY_CORRECT=1
IFS=$' \t\n'
\unset -f unset unalias
\unalias -a
unset POSIXLY_CORRECT

fail () { printf -- "ERROR: $*\n" 1>&2; 	exit 1; }

print_usage() {
	printf "
USAGE
	$0 <folder name>

where <folder name> is the name of the folder where the chess-game files will be stored.
"
	exit 1
}

[ $# -eq 1 ] || print_usage

root="$1"
[ -d "$root" ] || mkdir -p "$root" || fail "Cannot create folder '$root'"
cd "$root" || fail "Cannot change directory to '$root'"
trap "cd -- " EXIT

printf "Downloading chess-game file\n"
[ -f cgdata.pgn ] || wget -O cgdata.pgn -q https://raw.githubusercontent.com/rozim/ChessData/master/mega2400_part_01.pgn
[ $? -eq 0 ] || fail "Cannot download chess-game file" 

printf "Duplicating chess-game file for test\n"
for i in {00..99}; do
	cp cgdata{,.$i}.pgn || fail "Cannot generate test block files"
done
cat cgdata.[0-9][0-9].pgn > cgdata.all.pgn
