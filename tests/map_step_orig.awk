#!/usr/bin/mawk -f
# Map step as in the original article.
# Note that it fails to parse games with unknown state.
/Result/ { 
	split($0, a, "-")
	res = substr(a[1], length(a[1]), 1)
	if (res == 1) white++ 
	if (res == 0) black++ 
	if (res == 2) draw++ 
} 
END { print white+black+draw, white, black, draw }
