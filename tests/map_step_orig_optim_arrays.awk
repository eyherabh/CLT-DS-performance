#!/usr/bin/mawk -f
# Map step as in the original article optimized to avoid testing by using arrays.
# Note that it fails to parse games with unknown state.
/Result/ { 
	split($0, a, "-")
	res[substr(a[1], length(a[1]), 1)]++
} 
END { print res[1], res[0], res[2] }
