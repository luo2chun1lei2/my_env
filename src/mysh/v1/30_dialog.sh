# 显示dialog信息。

# 这是另外一种调用 exe 作为sub command 的方案。

MYENV_SH_SUPPORT_CMD="${MYENV_SH_SUPPORT_CMD} dialog"

function mysh_dialog_help()
{
    ${MYENV_TOOL_SH_VERSION_DIR}/exe/dialog
}

# $* 参数分析！
function mysh_dialog()
{
	${MYENV_TOOL_SH_VERSION_DIR}/exe/dialog $*
}
