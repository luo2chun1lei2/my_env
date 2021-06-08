#set -x

########################################
# 加载共通模块
########################################

source ${MYENV_TOOL_SRC_COMMON_PATH}/loader/loader.sh
source ${MYENV_TOOL_SRC_COMMON_PATH}/cmd_option/cmd_option.sh
source ${MYENV_TOOL_SRC_COMMON_PATH}/version/version.sh

########################################
# 加载额外的脚本和程序
########################################

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

########################################
# mysh
########################################

# 加载 myshe此版本的内部脚本
#echo "myenv_version_load_folder ${MYENV_TOOL_SRC_PATH}/mysh ${MYENV_TOOL_SH_VERSION}"
myenv_version_load_folder ${MYENV_TOOL_SRC_PATH}/mysh ${MYENV_TOOL_SH_VERSION}

########################################
# 跳转目录
########################################

# 跳转到目录中去
cd ${MYENV_CUR_PATH}

#set +x
