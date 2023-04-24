# 实现临时的路径记录和跳转

MYENV_SUPPORT_CMD="${MYENV_SUPPORT_CMD} refresh"

function myenv_refresh_help()
{
    printf 'myenv refresh [target]\n'
    printf '  refresh target\n'
    printf ' [target]:\n'
    printf '        : git pull newest myenv source.\n'
    printf '  myenv : git pull newest myenv source.\n'
}

# $* 参数分析！
function myenv_refresh()
{
	# 分析参数
	OPTS=`getopt -o h --long help -n "$(basename $0)" -- "$@"`
	if [ $? != 0 ]; then
		myenv_refresh_help
		return 1
	fi
	eval set -- "$OPTS"
	
	while true ; do
		case "$1" in
			-h|--help)
				myenv_refresh_help
				shift ; return 0 ;;
			--)
				shift ; break ;;
			*)
				myenv_refresh_help
				shift ; return 1 ;;
		esac
	done
	
	if [ $# -eq 0 ]; then
		# refresh myenv.
		(cd ${MYENV_TOOL_PATH} && git pull)
		return 0
	fi
	
	for target in $*; do
		case "$target" in
			myenv)
				(cd ${MYENV_TOOL_PATH} && git pull)
			shift
			;;
			*)
			myenv_refresh_help
			shift
			return 1
			;;
		esac
	done
}
