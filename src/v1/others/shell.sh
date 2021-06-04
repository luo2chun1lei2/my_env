
export MYENV_COMMON_SETTING="${MYENV_CONFIG_HOME}/env/common/setting.sh"
export MYENV_CUR_SETTING="${MYENV_CONFIG_HOME}/env/${MYENV_ENV_NAME}/setting.sh"

source ${MYENV_VERSION_DIR}/others/pre_common_setting.sh
#source ${MYENV_COMMON_SETTING}

source ${MYENV_VERSION_DIR}/others/pre_cur_setting.sh
#source ${MYENV_CUR_SETTING}

source ${MYENV_PATH}/.myenv/setting.sh
cd ${MYENV_PATH}
