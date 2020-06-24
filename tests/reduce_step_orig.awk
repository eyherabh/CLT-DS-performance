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

# \brief Reduce step as in the original article.
# Note that it can be optimized by performing the games computation in the END phase.
# Note that it fails to consider games with unknown state.
{
	games	+= $1
	white	+= $2
	black	+= $3
	draw	+= $4
} 
END {
	print games, white, black, draw
}
