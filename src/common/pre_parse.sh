# parse 之前的共通的启动项目！

#set -eo pipefail  # 如果想让函数命令返回其他的值，就不能设置这个。

# 调试设定
[[ "${TRACE}" ]] && set -x

# 工具本身的环境变量。
export MYENV_TOOL_SRC_COMMON_PATH="${MYENV_TOOL_SRC_PATH}/common"
export MYENV_TOOL_VERSION=1
export MYENV_TOOL_SH_VERSION=1

# 工具本身的版本
export MYENV_TOOL_VERSION_DIR=${MYENV_TOOL_SRC_PATH}/myenv/v${MYENV_TOOL_VERSION}
export MYENV_TOOL_SH_VERSION_DIR=${MYENV_TOOL_SRC_PATH}/mysh/v${MYENV_TOOL_VERSION}

# 加载共通的脚本
source ${MYENV_TOOL_SRC_COMMON_PATH}/utils/utils.sh
source ${MYENV_TOOL_SRC_COMMON_PATH}/version/version.sh
source ${MYENV_TOOL_SRC_COMMON_PATH}/cmd_option/cmd_option.sh
source ${MYENV_TOOL_SRC_COMMON_PATH}/loader/loader.sh

source ${MYENV_TOOL_SRC_PATH}/config/config.sh
source ${MYENV_TOOL_SRC_PATH}/env/env.sh

# ${HOME}/.myenv的宏。
export MYENV_HOME_CONFIG_PATH="${HOME}/.myenv"
export MYENV_HOME_CONFIG_KIND_PATH="${MYENV_HOME_CONFIG_PATH}/kind"
export MYENV_HOME_CONFIG_BIN_PATH="${MYENV_HOME_CONFIG_PATH}/bin"
export MYENV_HOME_CONFIG_SOURCE_PATH="${MYENV_HOME_CONFIG_PATH}/source"
export MYENV_HOME_CONFIG_DATA_PATH="${MYENV_HOME_CONFIG_PATH}/data"

export MYENV_HOME_CONFIG_MAP_NAME_PATH="${MYENV_HOME_CONFIG_DATA_PATH}/map_name_path"
