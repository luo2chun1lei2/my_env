# 实现临时的路径记录和跳转

MYENV_SH_SUPPORT_CMD="${MYENV_SH_SUPPORT_CMD} setd unsetd cdd listd"

# 路径数组
MYENV_TMP_PATH=()

function mysh_setd_help()
{
    PRG_NAME=$(basename "$0")
    
    printf '\n%s setd\n' ${PRG_NAME}
    printf '  set current directory into list\n'
}

# $* 参数分析！
function mysh_setd()
{
	# 分析参数
	OPTS=`getopt -o h --long help -n "$(basename $0)" -- "$@"`
	if [ $? != 0 ]; then
		mysh_setd_help
		return 1
	fi
	eval set -- "$OPTS"
	
	while true ; do
		case "$1" in
			-h|--help)
				mysh_setd_help
				shift ; return 0 ;;
			--)
				shift ; break ;;
			*)
				mysh_setd_help
				shift ; return 1 ;;
		esac
	done
	
	local path=`pwd`
	MYENV_TMP_PATH[${#MYENV_TMP_PATH[@]}]=$path
}

function mysh_unsetd_help()
{
    PRG_NAME=$(basename "$0")
    
    printf '\n%s unsetd [NO]\n' ${PRG_NAME}
    printf '  unset path by NO\n'
}

# $* 参数分析！
function mysh_unsetd()
{
	# 分析参数
	OPTS=`getopt -o h --long help -n "$(basename $0)" -- "$@"`
	if [ $? != 0 ]; then
		mysh_unsetd_help
		return 1
	fi
	eval set -- "$OPTS"
	
	while true ; do
		case "$1" in
			-h|--help)
				mysh_unsetd_help
				shift ; return 0 ;;
			--)
				shift ; break ;;
			*)
				mysh_unsetd_help
				shift ; return 1 ;;
		esac
	done
	
	if [ $# -ne 1 ]; then
		mysh_unsetd_help
	else
		unset MYENV_TMP_PATH[$1]
	fi
}

function mysh_listd_help()
{
    PRG_NAME=$(basename "$0")
    
    printf '\n%s listd\n' ${PRG_NAME}
    printf '  list all saved path\n'
}

# $* 参数分析！
function mysh_listd()
{
	# 分析参数
	OPTS=`getopt -o h --long help -n "$(basename $0)" -- "$@"`
	if [ $? != 0 ]; then
		mysh_listd_help
		return 1
	fi
	eval set -- "$OPTS"
	
	while true ; do
		case "$1" in
			-h|--help)
				mysh_listd_help
				shift ; return 0 ;;
			--)
				shift ; break ;;
			*)
				mysh_listd_help
				shift ; return 1 ;;
		esac
	done
	
	echo ${MYENV_TMP_PATH[*]}
}

function mysh_cdd_help()
{
    PRG_NAME=$(basename "$0")
    
    printf '\n%s cdd [no]\n' ${PRG_NAME}
    printf '  cd directory by NO, if not set cd env home.\n'
}

# $* 参数分析！
function mysh_cdd()
{
	# 分析参数
	OPTS=`getopt -o h --long help -n "$(basename $0)" -- "$@"`
	if [ $? != 0 ]; then
		mysh_cdd_help
		return 1
	fi
	eval set -- "$OPTS"
	
	while true ; do
		case "$1" in
			-h|--help)
				mysh_cdd_help
				shift ; return 0 ;;
			--)
				shift ; break ;;
			*)
				mysh_cdd_help
				shift ; return 1 ;;
		esac
	done
	
	if [ $# -eq 1 ]; then
		local path=${MYENV_TMP_PATH[$1]}
		cd $path
	else
		cd ${MYENV_CUR_PATH}
	fi
}
