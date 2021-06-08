# 显示帮助信息。

MYENV_SUPPORT_CMD="${MYENV_SUPPORT_CMD} help"

function myenv_help_help()
{
    PRG_NAME=$(basename "$0")
    
    printf '\n%s help [cmd]\n' ${PRG_NAME}
    printf '  show help, or show command help\n'
}

# $* 参数分析！
function myenv_help_parse_opts_and_do()
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
		for cmd in ${MYENV_SUPPORT_CMD}; do
			myenv_${cmd}_help
		done
	else
		for arg in $*; do
			echo "${MYENV_SUPPORT_CMD}" | grep -w $arg >/dev/null 2>&1
			if [ $? -eq 0 ]; then
				#echo "${arg}_help"
				myenv_${arg}_help
			else
				echo "Cannot find command $arg."
			fi
		done
	fi
}
