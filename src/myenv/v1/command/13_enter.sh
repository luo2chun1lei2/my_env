# 进入到 env 中去。

MYENV_SUPPORT_CMD="${MYENV_SUPPORT_CMD} enter"

function myenv_enter_help()
{
    PRG_NAME=$(basename "$0")
    
    printf '\n%s enter [env name|path] [option]\n' ${PRG_NAME}
    printf '  enter one environment by name of path.\n'
    printf '  If there is NO env in path, will fail.\n'
	printf ' [options]\n'
	printf '  -h/--help    show help.\n'
}

# $* 参数分析！
function myenv_enter()
{
	# 分析参数
	OPTS=`getopt -o h --long help -n "$(basename $0)" -- "$@"`
	if [ $? != 0 ]; then
		myenv_enter_help
		return 1
	fi
	eval set -- "$OPTS"
	
	while true ; do
		case "$1" in
			-h|--help)
				myenv_enter_help
				shift ; return 0 ;;
			--)
				shift ; break ;;
			*)
				myenv_enter_help
				shift ; return 1 ;;
		esac
	done
	
	if [ $# -gt 1 ]; then
		myenv_enter_help
		return 1
	fi

	OPT_INPUT=$1
	if [ -n "$OPT_INPUT" ]; then
		# Input 按照名字来分析
		MYENV_CUR_NAME="${OPT_INPUT}"
		MYENV_CUR_PATH=$(myenv_find_env_path_by_name ${MYENV_CUR_NAME})
		MYENV_CUR_PATH=$(myenv_check_env_path ${MYENV_CUR_PATH})

		if [ -z "${MYENV_CUR_PATH}" ]; then
			# Input不是名字，当做路径
			MYENV_CUR_NAME=
			MYENV_CUR_PATH=$(myenv_check_env_path ${OPT_INPUT})

			if [ -z "${MYENV_CUR_PATH}" ]; then
				# 还是无法定位环境
				echo "Input is not a name or valid path."
				return 1
			else
				MYENV_CUR_PATH=$(myenv_get_full_path ${MYENV_CUR_PATH})
			fi
		fi
	else
		# 没有Input，就找最近的环境
		MYENV_CUR_NAME=
		MYENV_CUR_PATH=$(myenv_find_nearest_env_path $(pwd))
		if [ -z "${MYENV_CUR_PATH}" ]; then
			echo "Cannot find one valid env."
			return 2
		fi
	fi

	MYENV_ENTER_ENV="y"
}
