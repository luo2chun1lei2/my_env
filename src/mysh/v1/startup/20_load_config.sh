# load config.sh and do

# 加载HOME ENV中的脚本和bin
#myenv_load_scripts ${MYENV_HOME_ENV_SOURCE_PATH}
#myenv_load_bin_to_path ${MYENV_HOME_ENV_BIN_PATH}

mysh_config_read $MYENV_CUR_ENV_CONFIG_PATH

# 缺省要加载 HOME MYENV.
mysh_config_load_needs "${HOME}:$MYENV_NEEDS"

# 如果没有重复，那么就加载用户自定义的脚本和bin
if [ "${MYENV_HOME_ENV_PATH}" != "${MYENV_CUR_ENV_PATH}" ]; then
	myenv_load_scripts ${MYENV_CUR_ENV_SOURCE_PATH}
	myenv_load_bin_to_path ${MYENV_CUR_ENV_BIN_PATH}
fi