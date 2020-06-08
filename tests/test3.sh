declare -i draw=0 black=0 white=0
cat "$1" | {
	while IFS= read -r line; do
		case "$line" in
			[Result\ *)
				 case "$line" in
					 *1-*) white+=1;;
					 *0-*) black+=1;;
					 *2*) draw+=1;;
				 esac;;
			 esac
			done;		 
		 

		 printf "$((white+black+draw)) $white $black $draw\n"
}
