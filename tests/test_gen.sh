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

# \brief Test workflow: reads files, sends them to the map step and finally ot the reduce step.

set -o pipefail

print_file_list() {
	local -i count="$1"
	while (( count-- )); do
		printf -- "data/cgdata.pgn\0"
	done
}

print_file_list "$1" | xargs -0 -n4 -P4 "$2" | "$3"
