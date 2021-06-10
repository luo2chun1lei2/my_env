# 显示dialog信息。

# 这是另外一种调用 exe 作为sub command 的方案。

MYENV_SH_SUPPORT_CMD="${MYENV_SH_SUPPORT_CMD} add_context del_context context"

function mysh_add_context_help()
{
    ${MYENV_TOOL_SH_VERSION_DIR}/exe/add_context.sh -h
}

# $* 参数分析！
function mysh_add_context()
{
	${MYENV_TOOL_SH_VERSION_DIR}/exe/add_context.sh $*
}

function mysh_del_context_help()
{
    ${MYENV_TOOL_SH_VERSION_DIR}/exe/del_context.sh -h
}

# $* 参数分析！
function mysh_del_context()
{
	${MYENV_TOOL_SH_VERSION_DIR}/exe/del_context.sh $*
}

function mysh_context_help()
{
    ${MYENV_TOOL_SH_VERSION_DIR}/exe/context.sh -h
}

# $* 参数分析！
function mysh_context()
{
	${MYENV_TOOL_SH_VERSION_DIR}/exe/context.sh $*
}
