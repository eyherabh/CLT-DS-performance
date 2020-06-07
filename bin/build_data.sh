# Generates test data

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
wget -O cgdata.pgn -q https://raw.githubusercontent.com/rozim/ChessData/master/mega2400_part_01.pgn
[ $? -eq 0 ] || fail "Cannot download chess-game file" 

printf "Duplicating chess-game file for test\n"
for i in {00..99}; do
	cp cgdata{,.$i}.pgn || fail "Cannot generate test block files"
done
cat cgdata.[0-9][0-9].pgn > cgdata.all.pgn
