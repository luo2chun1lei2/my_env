# 必须作为最后一个执行的脚本。

# 命令总的入口
# 1. 可以调用内部的命令
# 2. 可以调用外部的程序
function mysh()
{
	# 分析命令的参数
	myenv_cmd_option_parse_and_do ${MYENV_TOOL_SH_CUR_KIND_SUBCMD_EXE_PATH} "mysh" "${MYENV_SH_SUPPORT_CMD}" $*
}

export -f mysh
