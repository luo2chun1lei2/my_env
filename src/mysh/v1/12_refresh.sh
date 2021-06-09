# 实现临时的路径记录和跳转

MYENV_SH_SUPPORT_CMD="${MYENV_SH_SUPPORT_CMD} refresh"

function mysh_refresh_help()
{
    PRG_NAME=$(basename "$0")
    
    printf '\n%s refresh <target>\n' ${PRG_NAME}
    printf '  refresh target\n'
    printf ' <target>:\n'
    printf '  myenv : git pull newest myenv source.\n'
}

# $* 参数分析！
function mysh_refresh()
{
	# 分析参数
	OPTS=`getopt -o h --long help -n "$(basename $0)" -- "$@"`
	if [ $? != 0 ]; then
		mysh_refresh_help
		return 1
	fi
	eval set -- "$OPTS"
	
	while true ; do
		case "$1" in
			-h|--help)
				mysh_refresh_help
				shift ; return 0 ;;
			--)
				shift ; break ;;
			*)
				mysh_refresh_help
				shift ; return 1 ;;
		esac
	done
	
	for target in $*; do
		case "$target" in
			myenv)
				cd ${MYENV_TOOL_PATH} && git pull
			shift
			;;
			*)
			mysh_refresh_help
			shift
			return 1
			;;
		esac
	done
}
