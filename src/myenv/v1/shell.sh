#set -x

source ${MYENV_VERSION_DIR}/_path.sh
source ${MYENV_VERSION_DIR}/pre_setting.sh

# 这里执行 source/下面的所有的脚本！
for f in `find ${MYENV_PATH}/.myenv/source/ -type f | sort`; do
	source $f
done
export PATH=${PATH}:${MYENV_PATH}/.myenv/bin

source ${MYENV_VERSION_DIR}/post_setting.sh
cd ${MYENV_PATH}
