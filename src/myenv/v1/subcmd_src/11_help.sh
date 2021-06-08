# 显示帮助信息。

MYENV_SUPPORT_CMD="${MYENV_SUPPORT_CMD} help"

function myenv_help_help()
{
    PRG_NAME=$(basename "$0")
    
    printf '\n%s help [cmd]\n' ${PRG_NAME}
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
	
	if [ $# -eq 0 ]; then
		# 显示所有的命令的帮助信息
		for cmd in ${MYENV_SUPPORT_CMD}; do
			if [[ $cmd =~ .*:.* ]]; then
				cmd_path=${cmd#*:}
				${cmd_path} -h
			else
				myenv_${cmd}_help
			fi
		done
	else
		# 显示某个命令的帮助信息
		for cmd in $*; do
			echo "${MYENV_SUPPORT_CMD}" | grep -w "$cmd:" >/dev/null 2>&1
			if [ $? -eq 0 ]; then
				cmd_path=$(myenv_get_path_by_cmd $cmd ${MYENV_SUPPORT_CMD})
				if [ -f $cmd_path ]; then
					${cmd_path} -h
				else
					myenv_${cmd}_help
				fi
				#if [[ $cmd =~ .*:.* ]]; then
				#	cmd_path=${cmd#*:}
				#	${cmd_path} -h
				#else
				#	myenv_${cmd}_help
				#fi
			else
				echo "Cannot find command $cmd."
			fi
		done
	fi
}
