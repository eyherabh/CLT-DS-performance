#!/usr/bin/mawk -f
# Map step as in the original article optimized to avoid testing and split by using arrays.
# Note that it checks that the parsed results-line is well-formed.
# However, it still fails to parse games with unknown state.
# This version was used to show that, contrary to our expectations, compating using
# fix strings is slower than comparing using regular expressions.
$1 == "[Result" && NF==2 { res[$2]++ } 
END { print res["\"1-0\"]"], res["\"0-1\"]"], res["\"1/2-1/2\"]"] }
