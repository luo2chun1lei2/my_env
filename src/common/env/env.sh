# 负责和环境相关的部分。

# 创建此用户的环境配置
function myenv_create_env_of_user() {

	# 建立基本的配置文件。
	myenv_create_dir ${MYENV_HOME_CONFIG_PATH}

	myenv_create_env_by_path ${HOME}

	myenv_create_file ${MYENV_CONFIG_PATH}
	myenv_create_file ${MYENV_HOME_CONFIG_MAP_NAME_PATH}
}

# 根据路径创建环境
# $1 : env path
function myenv_create_env_by_path()
{
	TO_DIR="${1}/.myenv"
	myenv_create_dir $TO_DIR
	myenv_create_file $TO_DIR/kind		# 配置的类型
	myenv_create_dir $TO_DIR/bin		# 自定义的独立程序
	myenv_create_dir $TO_DIR/source		# 自定义的脚本
	myenv_create_dir $TO_DIR/data		# 自定义的数据
	
	return 0
}

# $1 : name
function myenv_find_env_path_by_name()
{
	local found_path
	found_path=`grep "$1:" $MYENV_HOME_CONFIG_MAP_NAME_PATH | awk -F ":" '{print $2}'`
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

	# sed无法处理带有“/”的路径，需要先将 "/"变成"\/"才行。
	# - 删除同名的
	sed -ri "/^$1:/d" $MYENV_HOME_CONFIG_MAP_NAME_PATH
	# - 删除同路径的
	local sed_path=$(echo $path | sed 's/\//\\\//g')
	sed -i '/:'${sed_path}'$/d' $MYENV_HOME_CONFIG_MAP_NAME_PATH
	# - 添加新的
	echo "$1:$path" >> $MYENV_HOME_CONFIG_MAP_NAME_PATH
	
	
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
