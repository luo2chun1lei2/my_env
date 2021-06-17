# parse 之后的共通的启动项目！


# 需要 MYENV_CUR_PATH / MYENV_CUR_NAME

# NOTICE: 下面的宏，不要在　subcmd 中使用，因为还没有设置!
# TODO: 这些设定，应该变成　函数 or 随同MYENV_CUR_PATH设置！
# ${MYENV_CUR_PATH}/.myenv 的宏
export MYENV_CUR_ENV_PATH="${MYENV_CUR_PATH}/.myenv"
export MYENV_CUR_ENV_CONFIG_PATH="${MYENV_CUR_ENV_PATH}/config.sh"
export MYENV_CUR_ENV_KIND_PATH="${MYENV_HOME_ENV_PATH}/kind"
export MYENV_CUR_ENV_BIN_PATH="${MYENV_CUR_ENV_PATH}/bin"
export MYENV_CUR_ENV_SOURCE_PATH="${MYENV_CUR_ENV_PATH}/source"
export MYENV_CUR_ENV_DATA_PATH="${MYENV_CUR_ENV_PATH}/data"
