
# 需要 MYENV_CUR_NAME 和 MYENV_CUR_NAME 都准备好。
function myenv_enter_env()
{
	# 进入env的新shell环境中。
	bash --rcfile ${MYENV_TOOL_VERSION_DIR}/shell.sh
}

# 进入env的新shell环境中。
if [ "${MYENV_ENTER_ENV}" == 'y' ]; then
	myenv_enter_env
fi
