#set -x

source ${MYENV_TOOL_SRC_COMMON_PATH}/loader/loader.sh

# 加载TOOL中的脚本和bin
myenv_load_scripts ${MYENV_TOOL_VERSION_DIR}/source
myenv_load_bin ${MYENV_TOOL_VERSION_DIR}/bin

# 加载HOME ENV中的脚本和bin
myenv_load_scripts ${MYENV_HOME_CONFIG_SOURCE_PATH}
myenv_load_bin ${MYENV_HOME_CONFIG_BIN_PATH}

if [ "${MYENV_HOME_CONFIG_PATH}" != "${MYENV_CUR_CONFIG_PATH}" ]; then
	# 加载用户自定义的脚本和bin
	myenv_load_scripts ${MYENV_CUR_CONFIG_SOURCE_PATH}
	myenv_load_bin ${MYENV_CUR_CONFIG_BIN_PATH}
fi

#set +x

# 跳转到目录中去
cd ${MYENV_CUR_PATH}
