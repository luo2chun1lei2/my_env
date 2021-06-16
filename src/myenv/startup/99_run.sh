
# 需要 MYENV_CUR_NAME 和 MYENV_CUR_NAME 都准备好。
function myenv_enter_env()
{
	# 进入env的新shell环境中，虽然不会自动加载 .bashrc，
	# 但是会传递 EXPORT 的环境变量。
	bash --rcfile ${MYENV_TOOL_SH_PATH}/shell.sh
}

# 进入env的新shell环境中。
if [ "${MYENV_ENTER_ENV}" == 'y' ]; then
	myenv_enter_env
fi
