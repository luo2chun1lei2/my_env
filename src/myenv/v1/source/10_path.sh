# 实现临时的路径记录和跳转

# 路径数组
MYENV_TMP_PATH=()

function setd_help()
{
    PRG_NAME=$(basename "$0")
    
    printf '\n%s setd\n' ${PRG_NAME}
    printf '  set current directory into list\n'
}

# $* 参数分析！
function setd()
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
	MYENV_TMP_PATH[${#MYENV_TMP_PATH[@]}]=$path
}

function unsetd_help()
{
    PRG_NAME=$(basename "$0")
    
    printf '\n%s unsetd [NO]\n' ${PRG_NAME}
    printf '  unset path by NO\n'
}

# $* 参数分析！
function unsetd()
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
	
	if [ $# -ne 1 ]; then
		unsetd_help
	else
		unset MYENV_TMP_PATH[$1]
	fi
}

function listd_help()
{
    PRG_NAME=$(basename "$0")
    
    printf '\n%s setd\n' ${PRG_NAME}
    printf '  set current directory into list\n'
}

# $* 参数分析！
function listd()
{
	# 分析参数
	OPTS=`getopt -o h --long help -n "$(basename $0)" -- "$@"`
	if [ $? != 0 ]; then
		listd_help
		return 1
	fi
	eval set -- "$OPTS"
	
	while true ; do
		case "$1" in
			-h|--help)
				listd_help
				shift ; return 0 ;;
			--)
				shift ; break ;;
			*)
				listd_help
				shift ; return 1 ;;
		esac
	done
	
	echo ${MYENV_TMP_PATH[*]}
}

function cdd_help()
{
    PRG_NAME=$(basename "$0")
    
    printf '\n%s cd [no]\n' ${PRG_NAME}
    printf '  cd directory by NO, if not set cd env home.\n'
}

# $* 参数分析！
function cdd()
{
	# 分析参数
	OPTS=`getopt -o h --long help -n "$(basename $0)" -- "$@"`
	if [ $? != 0 ]; then
		cdd_help
		return 1
	fi
	eval set -- "$OPTS"
	
	while true ; do
		case "$1" in
			-h|--help)
				cdd_help
				shift ; return 0 ;;
			--)
				shift ; break ;;
			*)
				cdd_help
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
