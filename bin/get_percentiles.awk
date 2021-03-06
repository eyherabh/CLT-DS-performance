#!/bin/awk -f
#
# Copyright (c) 2020 Ph.D. Hugo Gabriel Eyherabide
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

# \brief Computes percentiles

function fail(msg) {
	print msg > "/dev/stderr"
	exit 1 
}

function check_percentile(val) {
	if(val!=val+0) fail( "The parameter '" val "' is not numeric." )
	if(val>100 || val<0) fail( "The parameter '" val "' is not between 0 and 100" )
}

# Assumes that vals has at least one element and is sorted numerically in ascending order
function get_percentile(percentile, vals,    len, i, id, ret) {
        len = length(vals)
	
	if(len>1 && percentile>0) {
		i = percentile / 100.0 * (len-1) + 1
		id = int(i)
		ret = (vals[id+1]-vals[id])*(i-id)+vals[id]
	} else {
		ret = vals[1]
	} 
	
	return ret
}

function print_usage() {
	print ""
	print "NAME"
	print "\t" ENVIRON["_"] " - Computes percentiles for a list of newline-separated values (i.e. one per line/row)."
	print ""
	print "SYNOPSIS"
	print "\t" ENVIRON["_"] " <percentile1> ..."
	print ""
	exit 0
}

BEGIN {
	if(ARGC<2) print_usage()
	
	for(i=1; i<ARGC; i++)
		check_percentile(ARGV[i])

	while(getline < "/dev/stdin") 
		if($0 == $0+0)
			vals[++len] = $0
		else
			fail( "The value '" $0 "' is not numeric." )

	if(!len) fail( "Missing values" )
	
	asort(vals)

	OFS="\t"
	print "PERCENTILE", "VALUE"
	for(i=1; i<ARGC; i++) 
		print ARGV[i], get_percentile(ARGV[i], vals)
}
