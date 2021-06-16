# 显示一些信息

MYENV_SUPPORT_CMD="${MYENV_SUPPORT_CMD} info"

function myenv_info_help()
{
    PRG_NAME=$(basename "$0")
    
    printf '\n%s info [target] [option]\n' ${PRG_NAME}
    printf '  show information about myenv tool.\n'
	printf ' [target]\n'
	printf '          show list of name -> path.\n'
	printf '  kind    kind of myenv and mysh.\n'
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

	if [ $# == 0 ]; then
		cat ${MYENV_HOME_CONFIG_MAP_NAME_PATH}
		shift
	fi

	for targe in $*; do
		case "$1" in
			kind)
				printf "myenv: max=%s, current=%s\n" ${MYENV_TOOL_MAX_KIND} ${MYENV_TOOL_CUR_KIND}
				printf "mysh : max=%s, current=%s\n" ${MYENV_TOOL_SH_MAX_KIND} ${MYENV_TOOL_SH_CUR_KIND}
				echo `cd ${MYENV_TOOL_PATH} && echo -n git: && git log -1 --pretty=oneline`
				shift
				;;
			*)
				myenv_info_help
				shift ; return 1 ;;
		esac
	done

	return 0
}
