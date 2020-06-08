declare -i draw=0 black=0 white=0
	while read -r ini end; do
	case "$ini" in
		[Result)
			case "$end" in
				*1-*) white+=1;;
				*0-*) black+=1;;
				*2*) draw+=1;;
			esac;;
	esac
	done < "$1"


printf "$((white+black+draw)) $white $black $draw\n"

