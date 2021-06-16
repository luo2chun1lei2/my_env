# myenv 的命令实现，支持下面的格式
# myenv <subcmd>

MYENV_SUPPORT_CMD=
MYENV_ENTER_ENV=
# 需要导出到 mysh 中执行。
export MYENV_MYSH_CMDLINE=

# common functions

# $1 : name or path
function mysh_find_env()
{
    local OPT_INPUT=$1
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

    return 0
}