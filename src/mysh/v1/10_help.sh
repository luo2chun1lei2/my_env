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
		for cmd in ${MYENV_SH_SUPPORT_CMD}; do
			${prefix}_${cmd}_help
		done
	else
		for arg in $*; do
			echo "${MYENV_SH_SUPPORT_CMD}" | grep -w $arg >/dev/null 2>&1
			if [ $? -eq 0 ]; then
				#echo "${arg}_help"
				${prefix}_${arg}_help
			else
				echo "Cannot find command $arg."
			fi
		done
	fi
}
