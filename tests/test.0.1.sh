set -o pipefail
for i in {00..99}; do
	printf -- "data/cgdata.$i.pgn\0"
done \
	| xargs -0 -n4 -P4 tests/map_step_orig.awk \
	| tests/reduce_step_orig.awk
