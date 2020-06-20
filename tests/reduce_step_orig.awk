#!/usr/bin/mawk -f
# Reduce step as in the original article.
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
