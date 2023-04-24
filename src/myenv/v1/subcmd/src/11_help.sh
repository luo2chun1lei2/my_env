# 显示帮助信息。

MYENV_SUPPORT_CMD="${MYENV_SUPPORT_CMD} help"

function myenv_help_help()
{
    PRG_NAME=$(basename "$0")
    
    printf '%s help [cmd]\n' ${PRG_NAME}
    printf '  show help, or show command help\n'
}

# $* 参数分析！
function myenv_help()
{
	# 分析参数
	OPTS=`getopt -o h --long help -n "$(basename $0)" -- "$@"`
	if [ $? != 0 ]; then
		myenv_help_help
		return 1
	fi
	eval set -- "$OPTS"
	
	while true ; do
		case "$1" in
			-h|--help)
				myenv_help_help
				shift ; return 0 ;;
			--)
				shift ; break ;;
			*)
				myenv_help_help
				shift ; return 1 ;;
		esac
	done
	
	#set -x
	if [ $# -eq 0 ]; then
		# 显示所有的命令的帮助信息
		for cmd in ${MYENV_SUPPORT_CMD}; do
			myenv_${cmd}_help
			printf "\n"
		done

		for f in `find $MYENV_TOOL_CUR_KIND_SUBCMD_EXE_PATH -maxdepth 1 -type f  | sort`; do
			${f} -h
			printf "\n"
		done
	else
		# 显示某个命令的帮助信息
		for cmd in $*; do
			local found=0

			[[ `type -t myenv_${cmd}_help` == "function" ]] && myenv_${cmd}_help && found=1

			if [ $found -eq 0 ]; then
				for f in `ls -1 ${MYENV_TOOL_CUR_KIND_SUBCMD_EXE_PATH}/${cmd}* 2>/dev/null`; do
					$f -h
					found=1
					break
				done
			fi
				
			if [ $found -eq 0 ]; then
				echo "Cannot find command $cmd."
			fi
		done
	fi
}
