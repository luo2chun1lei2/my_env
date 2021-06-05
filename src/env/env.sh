# 负责和环境相关的部分。

# 创建此用户的环境配置
function myenv_create_env_of_user() {

	# 建立基本的配置文件。
	if [ ! -d "${MYENV_CONFIG_DIR}" ]; then
		mkdir -p ${MYENV_CONFIG_DIR}
	fi
	
	myenv_create_env_by_path ${HOME}

	touch ${MYENV_CONFIG_PATH}
	touch ${MYENV_CONFIG_MAP_NAME_PATH}
}

# 根据路径创建环境
# $1 : env path
function myenv_create_env_by_path()
{
	TO_DIR="${1}/.myenv"
	mkdir -p $TO_DIR
	mkdir -p $TO_DIR/bin		# 自定义的脚本
	touch $TO_DIR/setting.sh	# 自定义的设置
	
	return 1
}

# $1 : name
function myenv_find_env_path_by_name()
{
	local found_path
	found_path=`grep "$1:" $MYENV_CONFIG_MAP_NAME_PATH | awk -F ":" '{print $2}'`
	echo $found_path
}

# $1 name
# $2 path
function myenv_set_name_of_env_path()
{
	local path
	
	path=$(myenv_get_full_path $2)
	if [ -z "$path" ]; then
		echo "Cannot get full path of $path"
		return 1
	fi
	
	sed -ri "/^$1:/d" $MYENV_CONFIG_MAP_NAME_PATH
	# 不知道路径怎么放到 sed中。
	#sed -i "#:$path#d" $MYENV_CONFIG_MAP_NAME_PATH
	
	echo "$1:$path" >> $MYENV_CONFIG_MAP_NAME_PATH
	return 0
}

# $1 : env path
function myenv_check_env_path()
{
	if [ -d "${1}" -a -d "${1}/.myenv" ]; then
		echo $1
	else
		echo
	fi
}

# $1 : path
function myenv_find_nearest_env_path()
{
	if [ ! -d "$1" ]; then
		echo
	fi
	
	DIR=$1
	while [ 1 -eq 1 ]; do
		if [ -d "$DIR" -a -d "$DIR/.myenv" ]; then
			echo $DIR
			return
		fi
		DIR=`dirname ${DIR}`
		if [ "$DIR" == "/" ]; then
			echo
			return
		fi
	done
}
