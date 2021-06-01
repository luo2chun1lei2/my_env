
function mysh_cmd_option_parse() {
	if [ $# -eq 0 ]; then
		echo "Please input one action and options."
		exit 1
	fi

	case "$1" in
		help)
			usage $@
			exit 0;;
		init)
			shift
			mysh_init $@;;
		list)
			shift
			grp_list $@
			exit 0;;
		set)
			shift
			grp_set $@
			exit 0;;
		run)
			shift
			grp_run $@
			exit 0;;
		*)
			mysh_help 1>&2 ; exit 1;;
	esac
}


