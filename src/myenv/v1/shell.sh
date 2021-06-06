#set -x

source ${MYENV_VERSION_DIR}/_path.sh
source ${MYENV_VERSION_DIR}/pre_setting.sh

#source ${MYENV_PATH}/.myenv/source/setting.sh
# TODO 这里应该执行 source/下面的所有的脚本！
for f in `ls ${MYENV_PATH}/.myenv/source/ | sort`; do
	source $f
done

source ${MYENV_VERSION_DIR}/post_setting.sh
cd ${MYENV_PATH}
