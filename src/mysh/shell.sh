########################################
# 加载共通模块
########################################

source ${MYENV_TOOL_SRC_COMMON_PATH}/loader/loader.sh
myenv_load_scripts ${MYENV_TOOL_SRC_COMMON_PATH}

########################################
# 加载额外的脚本和程序
########################################

# 加载TOOL中的脚本和bin
myenv_load_scripts ${MYENV_TOOL_SH_CUR_KIND_PATH}/startup

########################################
# 加载 mysh 的 subcmd 脚本
########################################

# 加载 myshe此版本的内部脚本(subcmd/src)，subcmd/bin在运行时再分析。
myenv_load_scripts ${MYENV_TOOL_SH_CUR_KIND_SUBCMD_SRC_PATH}

########################################
# 跳转目录
########################################

# 跳转到目录中去
cd ${MYENV_CUR_PATH}

# 如果只需要执行一个命令，那么执行后就退出！
if [ -n "${MYENV_MYSH_CMDLINE}" ]; then
	mysh ${MYENV_MYSH_CMDLINE}
	# 执行完就退出。
	exit 0
fi
