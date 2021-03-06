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

# \brief Modified version of the original reduce step both optimized by computing
# the number of games in the END phase and corrected to take into account games with
# unknown state.
{
	white	+= $1
	black	+= $2
	draw	+= $3
	unknown += $4
}
END {
	print white+black+draw+unknown, white, black, draw, unknown
}
