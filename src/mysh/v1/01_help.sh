# 显示帮助信息。

MYENV_SH_SUPPORT_CMD="${MYENV_SH_SUPPORT_CMD} help"

function help_help()
{
    PRG_NAME=$(basename "$0")

#    printf '%s, assist to manage environment:\n' ${PRG_NAME}
#    printf '  Do action by different version.\n'
    
    printf '\n%s help [cmd]\n' ${PRG_NAME}
    printf '  show help, or show command help\n'
    
#    printf '\n%s list [project name pattern]\n' ${PRG_NAME}
#    printf '  list all projects or some project by name pattern (such as abc*).\n'
    
#    printf '\n%s set [project name]\n' ${PRG_NAME}
#    printf '  set current project. if not set project, then show current project.\n'
#    printf '  [project name]  project used, such as ecarx/ecarx in project list.\n'
#    printf '  -s/--show     Show result after loading config.\n'

#    printf '\n%s run command\n' ${PRG_NAME}
#    printf '  run command of current project.\n'
}

# $* 参数分析！
function help_parse_opts_and_do()
{
	# 分析参数
	OPTS=`getopt -o h --long help -n "$(basename $0)" -- "$@"`
	if [ $? != 0 ]; then
		help_help
		return 1
	fi
	eval set -- "$OPTS"
	
	while true ; do
		case "$1" in
			-h|--help)
				help_help
				shift ; return 0 ;;
			--)
				shift ; break ;;
			*)
				help_help
				shift ; return 1 ;;
		esac
	done
	
	if [ $# -eq 0 ]; then
		for cmd in ${MYENV_SH_SUPPORT_CMD}; do
			${cmd}_help
		done
	else
		for arg in $*; do
			echo "${MYENV_SH_SUPPORT_CMD}" | grep -w $arg >/dev/null 2>&1
			if [ $? -eq 0 ]; then
				#echo "${arg}_help"
				${arg}_help
			else
				echo "Cannot find command $arg."
			fi
		done
	fi
}
