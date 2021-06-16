# 进入到 env 中去。

MYENV_SUPPORT_CMD="${MYENV_SUPPORT_CMD} enter"

function myenv_enter_help()
{
    PRG_NAME=$(basename "$0")
    
    printf '\n%s enter [env name|path] [option]\n' ${PRG_NAME}
    printf '  enter one environment by name of path.\n'
    printf '  If there is NO env in path, will fail.\n'
	printf ' [options]\n'
	printf '  -h/--help    show help.\n'
}

# $* 参数分析！
function myenv_enter()
{
	# 分析参数
	OPTS=`getopt -o h --long help -n "$(basename $0)" -- "$@"`
	if [ $? != 0 ]; then
		myenv_enter_help
		return 1
	fi
	eval set -- "$OPTS"
	
	while true ; do
		case "$1" in
			-h|--help)
				myenv_enter_help
				shift ; return 0 ;;
			--)
				shift ; break ;;
			*)
				myenv_enter_help
				shift ; return 1 ;;
		esac
	done
	
	if [ $# -gt 1 ]; then
		myenv_enter_help
		return 1
	fi

	mysh_find_env $1
	if [ $? -ne 0 ]; then
		return $?
	fi

	MYENV_ENTER_ENV="y"
}
