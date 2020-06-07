# Runs test; computes median and quantiles

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

tmpfile=$(mktemp benchmark_"${1//\//.}"_XXXXXX) || fail "Cannot create temporary file for benchmarking"

for i in {1..9}; do
	\time -f '%e' -o "$tmpfile" -a bash "$1" &>/dev/null || fail "Fail while running test script"
done

bin/get_median.sh "$tmpfile"
