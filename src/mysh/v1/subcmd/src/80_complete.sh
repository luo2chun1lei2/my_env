# 显示complete信息。

MYENV_SH_SUPPORT_CMD="${MYENV_SH_SUPPORT_CMD} complete"

function mysh_complete_help()
{
    PRG_NAME=$(basename "$0")
    
    printf 'mysh complete [cmd]\n'
    printf '  show complete information.'
}

# $* 参数分析！
function mysh_complete()
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
			echo -n "${cmd} "
		done

		for f in `find $MYENV_TOOL_SH_CUR_KIND_SUBCMD_EXE_PATH -maxdepth 1 -type f  | sort`; do
			echo -n "$(basename ${f}) "
		done
	else
		echo "Cannot set concrete target."
	fi
}
