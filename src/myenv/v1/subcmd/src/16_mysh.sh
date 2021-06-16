# 实现临时的路径记录和跳转

MYENV_SUPPORT_CMD="${MYENV_SUPPORT_CMD} mysh"

function myenv_mysh_help()
{
    printf '\nmyenv [options] mysh ...\n'
    printf '    execute command by mysh\n'
	printf '    ... is mysh options.\n'
	printf '  example:\n'
	printf '    myenv mysh -- add_context aaa bbb ccc -- -abc'
	printf '    myenv mysh -- context -l'
    printf '  [options]:\n'
    printf '    -e/--env : env name or path.\n'
    printf '      if not set , find nearest env.\n'
}

# $* 参数分析！
function myenv_mysh()
{
	# 分析参数
	OPTS=`getopt -o he --long help,env: -n "$(basename $0)" -- "$@"`
	if [ $? != 0 ]; then
		myenv_refresh_help
		return 1
	fi
	eval set -- "$OPTS"
	
    local OPT_ENV

	while true ; do
		case "$1" in
			-h|--help)
				myenv_refresh_help
				shift ; return 0 ;;
            -e|--env)
				OPT_ENV=$2
				shift 2
                ;;
			--)
				shift ; break ;;
			*)
				myenv_refresh_help
				shift ; return 1 ;;
		esac
	done

    mysh_find_env $OPT_ENV
	if [ $? -ne 0 ]; then
		echo "Cannot find env."
        return 1
	fi
	
    MYENV_MYSH_CMDLINE="$*"
    MYENV_ENTER_ENV="y"
}
