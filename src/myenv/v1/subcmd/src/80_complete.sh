# 显示complete信息。

MYENV_SUPPORT_CMD="${MYENV_SUPPORT_CMD} complete"

function myenv_complete_help()
{
    PRG_NAME=$(basename "$0")
    
    printf '\n%s complete [cmd]\n' ${PRG_NAME}
    printf '  show complete information.\n'
}

# $* 参数分析！
function myenv_complete()
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
			echo -n "${cmd} "
		done

		for f in `find $MYENV_TOOL_CUR_KIND_SUBCMD_EXE_PATH -maxdepth 1 -type f  | sort`; do
			echo -n "`basename ${f}` "
		done
	else
		echo "Cannot set concrete target."
	fi
}
