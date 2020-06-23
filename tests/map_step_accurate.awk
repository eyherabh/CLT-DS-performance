#!/usr/bin/mawk -f
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

# \brief Map step as in the original article optimized to avoid testing and split by using arrays.
# Note that it checks that the parsed results-line is well-formed.
# However, it still fails to parse games with unknown state.
/^\[Result / && NF==2 { res[$2]++ } 
END { print res["\"1-0\"]"], res["\"0-1\"]"], res["\"1/2-1/2\"]"] }
