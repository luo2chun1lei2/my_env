# 暂时放在这里，根本不对！

# 记录路径和跳转
# setd path to name
# used name

MYENV_SUPPORT_CMD="${MYENV_SUPPORT_CMD} setd unsetd cdd"

# 路径数组
MYENV_TMP_PATH=()

function setd_help()
{
    PRG_NAME=$(basename "$0")
    
    printf '\n%s setd\n' ${PRG_NAME}
    printf '  set current directory into list\n'
}

# $* 参数分析！
function setd_parse_opts_and_do()
{
	# 分析参数
	OPTS=`getopt -o h --long help -n "$(basename $0)" -- "$@"`
	if [ $? != 0 ]; then
		setd_help
		return 1
	fi
	eval set -- "$OPTS"
	
	while true ; do
		case "$1" in
			-h|--help)
				setd_help
				shift ; return 0 ;;
			--)
				shift ; break ;;
			*)
				setd_help
				shift ; return 1 ;;
		esac
	done
	
	local path=`pwd`
	MYENV_TMP_PATH[${MYENV_TMP_PATH[@]}]=$path
}

function unsetd_help()
{
    PRG_NAME=$(basename "$0")
    
    printf '\n%s unsetd [NO]\n' ${PRG_NAME}
    printf '  unset path by NO\n'
}

# $* 参数分析！
function unsetd_parse_opts_and_do()
{
	# 分析参数
	OPTS=`getopt -o h --long help -n "$(basename $0)" -- "$@"`
	if [ $? != 0 ]; then
		unsetd_help
		return 1
	fi
	eval set -- "$OPTS"
	
	while true ; do
		case "$1" in
			-h|--help)
				unsetd_help
				shift ; return 0 ;;
			--)
				shift ; break ;;
			*)
				unsetd_help
				shift ; return 1 ;;
		esac
	done
	
	if [ $# -nq 1 ]; then
		unsetd_help
	else
		unset MYENV_TMP_PATH[$1]
	fi
}

function cd_help()
{
    PRG_NAME=$(basename "$0")
    
    printf '\n%s cd <no>\n' ${PRG_NAME}
    printf '  cd directory by NO\n'
}

# $* 参数分析！
function cd_parse_opts_and_do()
{
	# 分析参数
	OPTS=`getopt -o h --long help -n "$(basename $0)" -- "$@"`
	if [ $? != 0 ]; then
		cd_help
		return 1
	fi
	eval set -- "$OPTS"
	
	while true ; do
		case "$1" in
			-h|--help)
				cd_help
				shift ; return 0 ;;
			--)
				shift ; break ;;
			*)
				cd_help
				shift ; return 1 ;;
		esac
	done
	
	if [ $# -eq 1 ]; then
		local path=${MYENV_TMP_PATH[$1]}
		cd $path
	else
		cd_help
	fi
}
