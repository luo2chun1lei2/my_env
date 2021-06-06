# 放一些共通的模块，启动的环境。

export MYENV_CONFIG_HOME="${HOME}/.my_shell"
export MYENV_CONFIG_NAME="config.sh"

# user的特殊配置。
export MYENV_CONFIG_DIR="${HOME}/.myenv"
export MYENV_CONFIG_PATH="${MYENV_CONFIG_DIR}/config.sh"
export MYENV_BIN_PATH="${MYENV_CONFIG_DIR}/bin"
export MYENV_SOURCE_PATH="${MYENV_CONFIG_DIR}/source"
export MYENV_DATA_PATH="${MYENV_CONFIG_DIR}/data"

export MYENV_CONFIG_MAP_NAME_PATH="${MYENV_DATA_PATH}/map_name_path"

# $1 : path
function myenv_get_full_path()
{
	if [ -d "$1" ]; then
		echo "$(cd "$1" && pwd)"
	elif [ -f $1 ]; then
		FN=`basename $1`
		echo "$(cd "$(dirname "$1")" && pwd)/$FN"
	fi
	echo
}

# 根据path，生成缩略路径
# $1 : path
function myenv_get_abbr_path()
{
	base1=$(basename $1)
	base2=$(basename $(dirname $1))
	echo "$base2/$base1"
}
export -f myenv_get_abbr_path

# 经过判断才创建文件，避免修改文件的时间.
# $1 path
function myenv_create_file()
{
	if [ ! -f $1 ]; then
		touch $1
	fi
}

# 经过判断才创建文件夹
# $1 path
function myenv_create_dir()
{
	if [ ! -d $1 ]; then
		mkdir -p $1
	fi
}

# 加载必要的工具
source ${MYENV_SRC_DIR}/config/config.sh
source ${MYENV_SRC_DIR}/common/version/version.sh
source ${MYENV_SRC_DIR}/common/cmd_option/cmd_option.sh
source ${MYENV_SRC_DIR}/env/env.sh
