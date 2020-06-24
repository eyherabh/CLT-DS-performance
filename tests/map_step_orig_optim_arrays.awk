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

# \brief Map step as in the original article optimized to avoid testing by using arrays.
# Note that it fails to parse games with unknown state.
/Result/ { 
	split($0, a, "-")
	res[substr(a[1], length(a[1]), 1)]++
} 
END { print res[1], res[0], res[2] }
