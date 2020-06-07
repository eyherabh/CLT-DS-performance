set -o pipefail
for i in {0..99}; do printf -- "data/cgdata.$i.pgn\0"; done \
	| xargs -0 -n4 -P4 mawk '/Result/ { 
	  	       	   		 split($0, a, "-")
	  				 res = substr(a[1], length(a[1]), 1)
	   				 if (res == 1) white++ 
	   				 if (res == 0) black++ 
	   				 if (res == 2) draw++ 
				 } 
				 END { print white+black+draw, white, black, draw }' \
	| mawk '{ games += $1; white += $2; black += $3; draw += $4; } 
	        END { print games, white, black, draw }'

