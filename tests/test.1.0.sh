set -o pipefail
for i in {0..99}; do printf -- "data/cgdata.00.pgn\0"; done \
	| xargs -0 -n4 -P4 mawk '/Result/ { 
	  	       	   		 split($0, a, "-")
	  				 res = substr(a[1], length(a[1]), 1)
	   				 if (res == 1) white++ 
	   				 else if (res == 0) black++ 
	   				 else if (res == 2) draw++ 
				 } 
				 END { print white, black, draw }' \
	| mawk '{white += $1; black += $2; draw += $3; } 
	        END { print white+black+draw, white, black, draw }'
