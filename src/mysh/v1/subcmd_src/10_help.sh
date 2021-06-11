# 显示帮助信息。

MYENV_SH_SUPPORT_CMD="${MYENV_SH_SUPPORT_CMD} help"

function mysh_help_help()
{
    printf '\nmysh help [cmd]\n'
    printf '  show help, or show command help\n'
}

# $* 参数分析！
function mysh_help()
{
	local prefix="mysh"
	
	# 分析参数
	OPTS=`getopt -o h --long help -n "$(basename $0)" -- "$@"`
	if [ $? != 0 ]; then
		${prefix}_help_help
		return 1
	fi
	eval set -- "$OPTS"
	
	while true ; do
		case "$1" in
			-h|--help)
				${prefix}_help_help
				shift ; return 0 ;;
			--)
				shift ; break ;;
			*)
				${prefix}_help_help
				shift ; return 1 ;;
		esac
	done
	
	if [ $# -eq 0 ]; then
		# 显示所有的帮助
		for cmd in ${MYENV_SH_SUPPORT_CMD}; do
			${prefix}_${cmd}_help
		done

		for f in `find $MYENV_TOOL_SH_VERSION_SUBCMD_EXE_PATH -maxdepth 1 -type f  | sort`; do
			${f} -h
		done
	else
		# 显示指定命令的帮助
		for cmd in $*; do
			local found=0

			[[ `type -t ${prefix}_${cmd}_help` == "function" ]] && ${prefix}_${cmd}_help && found=1

			if [ $found -eq 0 ]; then
				for f in `ls -1 ${MYENV_TOOL_SH_VERSION_SUBCMD_EXE_PATH}/${cmd}* 2>/dev/null`; do
					$f -h
					found=1
					break
				done
			fi
				
			if [ $found -eq 0 ]; then
				echo "Cannot find command($cmd)."
			fi
		done
	fi
}
