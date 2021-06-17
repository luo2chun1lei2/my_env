# 显示一些信息

MYENV_SUPPORT_CMD="${MYENV_SUPPORT_CMD} info"

function myenv_info_help()
{
    PRG_NAME=$(basename "$0")
    
    printf '\n%s info [target] [option]\n' ${PRG_NAME}
    printf '    show information about myenv tool.\n'
	printf '  [target]\n'
	printf '            show list of name -> path.\n'
	printf '    kind    kind of myenv and mysh.\n'
	printf '  [option]\n'
	printf '    -h/--help    show help.\n'
	printf '    -n/--name    just show name if not set target FOR COMPLETE.\n'
}

# $* 参数分析！
function myenv_info()
{
	# 分析参数
	OPTS=`getopt -o hn --long help,name -n "$(basename $0)" -- "$@"`
	if [ $? != 0 ]; then
		myenv_info_help
		return 1
	fi
	eval set -- "$OPTS"
	
	local OPT_JUST_NAME=n
	while true ; do
		case "$1" in
			-h|--help)
				myenv_info_help
				shift
				return 0 ;;
			-n|--name)
				OPT_JUST_NAME=y
				shift
				;;
			--)
				shift ; break ;;
			*)
				myenv_info_help
				shift
				return 1 ;;
		esac
	done

	if [ $# == 0 ]; then
		if [ "${OPT_JUST_NAME}" == 'y' ]; then
			cat ${MYENV_HOME_ENV_MAP_NAME_PATH} | awk -F ":" '{print $1}'
			myenv_find_nearest_env_path `pwd`
		else
			cat ${MYENV_HOME_ENV_MAP_NAME_PATH}
			myenv_find_nearest_env_path `pwd`
		fi
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
