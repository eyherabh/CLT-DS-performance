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

# \brief Runs test; computes median and quantiles

POSIXLY_CORRECT=1
IFS=$' \t\n'
\unset -f unset unalias
\unalias -a
unset POSIXLY_CORRECT

fail () { printf -- "ERROR: $*\n" 1>&2; 	exit 1; }

print_usage() {
	printf "
USAGE
	$0 <script path>

where <script path> is the path to the test script.
"
	exit 1
}

[ $# -eq 1 ] && [ -f "$1" ] || print_usage

tmpfile=$(mktemp benchmark/benchmark_"${1//\//.}"_XXXXXX) || fail "Cannot create temporary file for benchmarking"

for i in {1..9}; do
	\time -f '%e' -o "$tmpfile" -a bash "$1" &>/dev/null || fail "Fail while running test script"
done

title="Percentiles"
value="Duration"
while read -r percentile duration; do
	title+="\t$percentile"
	value+="\t$duration"
done < <(bin/get_percentiles.awk 25 50 75 < "$tmpfile" | tail -n +2)
printf "$title\n$value\n"
