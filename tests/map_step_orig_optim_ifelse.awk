#!/usr/bin/mawk -f
# Map step as in the original article optimized to avoid redundant testing by using if-else.
# Note that it fails to parse games with unknown state.
/Result/ { 
	split($0, a, "-")
	res = substr(a[1], length(a[1]), 1)
	if (res == 1) white++ 
	else if (res == 0) black++ 
	else if (res == 2) draw++ 
} 
END { print white, black, draw }
