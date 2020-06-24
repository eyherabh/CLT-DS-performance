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

# \brief Test race conditions
#
# First, printing some counts so that each map step (second line)
# produces 6 characters plus the newline. That way, a total of 7
# characters is produced, which is unlikely to be coprime of the
# stdout buffer size. The reduce step simply validates the lines it
# receives.
		    
printf "%s\n" 111111 222222 333333 444444 | xargs -n 1 -P 4 -I{} \
	awk -v word={} 'BEGIN { for(i=2^16;i--;) print word > "/dev/stderr" }' |&
	awk '$0 !~ /^[1-4]{6}$/; END { print NR }'

