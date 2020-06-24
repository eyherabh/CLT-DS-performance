#!/usr/bin/mawk -f
#
# This program is derivative work from that shown by Adam Drake in https://adamdrake.com/command-line-tools-can-be-235x-faster-than-your-hadoop-cluster.html.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

# \brief Modified version of the original reduce step optimized by computing the number of games in the END phase.
# Note that it still fails to consider games with unknown state.
{
	white	+= $1
	black	+= $2
	draw	+= $3
	unknown += $4
}
END {
	print white+black+draw+unknown, white, black, draw, unknown
}
