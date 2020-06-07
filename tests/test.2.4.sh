set -o pipefail
for i in {0..99}; do printf -- "data/cgdata.00.pgn\0"; done \
	| xargs -0 -n4 -P4 mawk '
	  	      		/^\[Result / && NF==2 { res[$2]++ } 
				END { print res["\"1-0\"]"], res["\"0-1\"]"], res["\"1/2-1/2\"]"], res["\"*\"]"] }' \
	| mawk '{white += $1; black += $2; draw += $3; unknown += $4} 
	        END { print white+black+draw+unknown, white, black, draw, unknown }'
