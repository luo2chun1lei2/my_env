
export MYENV_COMMON_SETTING="${MYENV_CONFIG_HOME}/env/common/setting.sh"
export MYENV_CUR_SETTING="${MYENV_CONFIG_HOME}/env/${MYENV_ENV_NAME}/setting.sh"

source ${MYENV_VERSION_DIR}/others/pre_setting.sh
source ${MYENV_PATH}/.myenv/setting.sh
source ${MYENV_VERSION_DIR}/others/post_setting.sh
cd ${MYENV_PATH}
