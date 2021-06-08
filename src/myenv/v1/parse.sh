# $0 是程序的名字.
function myenv_help()
{
	printf "%s <command> [options]\n" `basename $0`
	printf "  init [path] --name/-n path"
	printf "    env name is set in ~/.myenv/map_name_path.\n"
	printf "    Or there is .myenv in Path.\n"
	printf "    If empty, find nearest .myenv in up directory.\n"
	printf "  options:\n"
	printf "    -c/--create : create a env by path or current pwd.\n"
	printf "    -n/--name <name> : set name to path.\n"
}

# 环境所在的目录
export MYENV_CUR_PATH=
# 环境的名字
export MYENV_CUR_NAME=

# 生成用户的环境配置文件
# 每次都强制执行，这样配置文件都是全的。
myenv_create_env_of_user

# 加载工具本身的配置
#source ${MYENV_TOOL_SRC_PATH}/env/pre_env.sh
# 加载user环境中的配置
#source ${MYENV_CUR_CONFIG_PATH}

# TODO 后面这个地址要修改！
myenv_load_scripts ${MYENV_TOOL_SRC_PATH}/myenv/v1/command

myenv_cmd_option_parse_and_do "myenv" "${MYENV_SUPPORT_CMD}" $*
