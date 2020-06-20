#!/usr/bin/mawk -f
# Modified version of the original reduce step both optimized by computing
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
