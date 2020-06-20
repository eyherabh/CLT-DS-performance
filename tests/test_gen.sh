set -o pipefail
for i in $(seq -f '%02.0f' 0 "$1"); do
	printf -- "data/cgdata.00.pgn\0"
done | xargs -0 -n4 -P4 "$2" | "$3"
