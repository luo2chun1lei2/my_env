# 开始

# 共通的启动项目！

# 工具本身的版本
# - myenv
export MYENV_TOOL_CUR_KIND_PATH=${MYENV_TOOL_SRC_PATH}/myenv/v${MYENV_TOOL_CUR_KIND}
export MYENV_TOOL_CUR_KIND_SUBCMD_SRC_PATH=${MYENV_TOOL_CUR_KIND_PATH}/subcmd/src
export MYENV_TOOL_CUR_KIND_SUBCMD_EXE_PATH=${MYENV_TOOL_CUR_KIND_PATH}/subcmd/bin

# - mysh
export MYENV_TOOL_SH_CUR_KIND_PATH=${MYENV_TOOL_SRC_PATH}/mysh/v${MYENV_TOOL_CUR_KIND}
export MYENV_TOOL_SH_CUR_KIND_SUBCMD_SRC_PATH=${MYENV_TOOL_SH_CUR_KIND_PATH}/subcmd/src
export MYENV_TOOL_SH_CUR_KIND_SUBCMD_EXE_PATH=${MYENV_TOOL_SH_CUR_KIND_PATH}/subcmd/bin


# ${HOME}/.myenv的宏。
export MYENV_HOME_ENV_PATH="${HOME}/.myenv"
export MYENV_HOME_ENV_CONFIG_PATH="${MYENV_HOME_ENV_PATH}/config.sh"
export MYENV_HOME_ENV_KIND_PATH="${MYENV_HOME_ENV_PATH}/kind"
export MYENV_HOME_ENV_BIN_PATH="${MYENV_HOME_ENV_PATH}/bin"
export MYENV_HOME_ENV_SOURCE_PATH="${MYENV_HOME_ENV_PATH}/source"
export MYENV_HOME_ENV_DATA_PATH="${MYENV_HOME_ENV_PATH}/data"

export MYENV_HOME_ENV_MAP_NAME_PATH="${MYENV_HOME_ENV_DATA_PATH}/map_name_path"

# set MYENV_CUR_PATH，顺便设置相关的变量。
# $1
function myenv_set_cur_path()
{
    export MYENV_CUR_PATH=$1
    export MYENV_CUR_ENV_PATH="${MYENV_CUR_PATH}/.myenv"
    export MYENV_CUR_ENV_CONFIG_PATH="${MYENV_CUR_ENV_PATH}/config.sh"
    export MYENV_CUR_ENV_KIND_PATH="${MYENV_HOME_ENV_PATH}/kind"
    export MYENV_CUR_ENV_BIN_PATH="${MYENV_CUR_ENV_PATH}/bin"
    export MYENV_CUR_ENV_SOURCE_PATH="${MYENV_CUR_ENV_PATH}/source"
    export MYENV_CUR_ENV_DATA_PATH="${MYENV_CUR_ENV_PATH}/data"

}

#######################################
# .myenv/config.sh 中的设置项目
#######################################

# 牵连其他的环境，进入环境后，导入 $NEEDS/source 和 $NEEDS/bin。
# 可以有多个，中间用“:”来分割。
export MYENV_NEEDS=