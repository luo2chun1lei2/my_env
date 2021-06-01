
export MYSH_COMMON_SETTING="${MYSH_CONFIG_HOME}/env/common/setting.sh"
export MYSH_CUR_SETTING="${MYSH_CONFIG_HOME}/env/${MYSH_ENV_NAME}/setting.sh"

source ${MYSH_VERSION_DIR}/others/pre_common_setting.sh
source ${MYSH_COMMON_SETTING}

source ${MYSH_VERSION_DIR}/others/pre_cur_setting.sh
source ${MYSH_CUR_SETTING}
