# 显示一些信息

MYENV_SUPPORT_CMD="${MYENV_SUPPORT_CMD} info"

function myenv_info_help()
{
    PRG_NAME=$(basename "$0")
    
    printf '\n%s info target [option]\n' ${PRG_NAME}
    printf '  show information about myenv tool.\n'
	printf ' [target]\n'
	printf '  name    show list of name -> path.\n'
	printf '  version version of myenv and mysh.\n'
	printf ' [option]\n'
	printf '  -h/--help    show help.\n'
}

# $* 参数分析！
function myenv_info()
{
	# 分析参数
	OPTS=`getopt -o h --long help -n "$(basename $0)" -- "$@"`
	if [ $? != 0 ]; then
		myenv_info_help
		return 1
	fi
	eval set -- "$OPTS"
	
	while true ; do
		case "$1" in
			-h|--help)
				myenv_info_help
				shift ; return 0 ;;
			--)
				shift ; break ;;
			*)
				myenv_info_help
				shift ; return 1 ;;
		esac
	done


	for targe in $*; do
		case "$1" in
			version)
				printf "myenv:%s\n" ${MYENV_TOOL_VERSION}
				printf "mysh :%s\n" ${MYENV_TOOL_SH_VERSION}
				shift
				;;
			name)
				cat ${MYENV_HOME_CONFIG_MAP_NAME_PATH}
				shift
				;;
			*)
				myenv_info_help
				shift ; return 1 ;;
		esac
	done
}
