# Computes median from a file with a list of values (one per row)

POSIXLY_CORRECT=1
IFS=$' \t\n'
\unset -f unset unalias
\unalias -a
unset POSIXLY_CORRECT

fail () { printf -- "ERROR: $*\n" 1>&2; 	exit 1; }

print_usage() {
	printf "
USAGE
	$0 <file name>

where <file name> is the path to a file containing one value per row.
"
	exit 1
}

[ $# -eq 1 ] && [ -f "$1" ] || print_usage

readarray -t vals < <(sort -n "$1") || fail "Cannot read input file"

vsize=${#vals[@]}
vmedian=$((vsize/2))

if [ $((vmedian*2)) -eq $vsize ]; then
	median="$(printf "scale=2; (${vals[$vmedian-1]} + ${vals[$vmedian]})/2\n" | bc )" || fail "Cannot compute the emdian"
else
	median=${vals[vmedian]}
fi

printf "$median"
