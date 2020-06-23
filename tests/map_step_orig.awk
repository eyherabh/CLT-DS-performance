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

# \brief Map step as in the original article.
# Note that it fails to parse games with unknown state.
/Result/ { 
	split($0, a, "-")
	res = substr(a[1], length(a[1]), 1)
	if (res == 1) white++ 
	if (res == 0) black++ 
	if (res == 2) draw++ 
} 
END { print white+black+draw, white, black, draw }
