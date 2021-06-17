# 初始化某个环境。

MYENV_SUPPORT_CMD="${MYENV_SUPPORT_CMD} init"

function myenv_init_help()
{
    PRG_NAME=$(basename "$0")
    
    printf '\n%s init [env path] [option]\n' ${PRG_NAME}
    printf '  initialize a environment on path.\n'
    printf '  If there is env in path, or create all files and folders for new version.\n'
	printf ' [options]\n'
	printf '  -h/--help    show help.\n'
	printf '  -n/--name <name>  set name to this path.\n'
	printf '               If name or path exists, set new name to path and remove old one.\n'
    printf '  -e/--enter   enter the environment after create enviroment.\n'

}

# $* 参数分析！
function myenv_init()
{
	# 分析参数
	OPTS=`getopt -o hn:e --long help,name:,enter -n "$(basename $0)" -- "$@"`
	if [ $? != 0 ]; then
		myenv_init_help
		return 1
	fi
	eval set -- "$OPTS"

	local SET_ENV_NAME=
	local ENTER_ENV=n
	
	while true ; do
		case "$1" in
			-h|--help)
				myenv_init_help
				shift
				return 0
				;;
			-n|--name)
				SET_ENV_NAME=$2
				shift 2
				;;
			-e|--enter)
				ENTER_ENV=y
				shift
				;;
			--)
				shift
				break
				;;
			*)
				myenv_init_help
				shift
				return 1
				;;
		esac
	done
	
	if [ $# -eq 0 ]; then
		# 按照当前的路径算
		MYENV_CUR_NAME=
		myenv_set_cur_path $(pwd)
	elif [ $# -eq 1 ]; then
		# 如果有路径
		MYENV_CUR_NAME=
		myenv_set_cur_path $(myenv_get_full_path ${1})
	else
		# 需要创建的太多了！
		myenv_init_help
		return 1
	fi

	# 无论是否存在，都要创建，这样可以加入新的文件夹和文件，但是已有内容不会修改。
	myenv_create_env_by_path ${MYENV_CUR_PATH}/.myenv
	if [ $? -ne 0 ]; then
		exit 1
	fi

	if [ -n "${SET_ENV_NAME}" ]; then
		MYENV_CUR_NAME=$SET_ENV_NAME
		myenv_set_name_of_env_path $MYENV_CUR_NAME $MYENV_CUR_PATH
		if [ $? -ne 0 ]; then
			exit 1
		fi
	fi

	if [ "${ENTER_ENV}" == 'y' ]; then
		MYENV_ENTER_ENV=${ENTER_ENV}
	fi

	return 0
}
