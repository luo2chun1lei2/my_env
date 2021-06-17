
# 生成 config文件。
# $1 config file path
function mysh_config_create()
{
	local CONFIG_PATH=$1
	local CONFIG_DIR=$(dirname $1)

	if [ -f ${CONFIG_PATH} ]; then
		return 0
	fi
	
	mkdir -p ${CONFIG_DIR}
	myenv_create_file ${CONFIG_PATH}
	# 文件的内容由用户自己填写。
	
	return 0
}

# 读取 config　文件。
# $1 config file path
function mysh_config_read()
{
	if [ ! -f $1 ]; then
		return 1
	fi

	source $1

	return 0
}

# $1 : 关联的 .myenv 的名字或者路径！用":"分开。
function mysh_config_load_needs()
{
	local found
	for one in `echo $1 | tr ':' ' '`; do
		found=$(mysh_find_env2 $one)
		if [ $? -eq 0 ]; then
			local myenv_path=${found#*:}
			myenv_load_bin_to_path $myenv_path/.myenv/bin
			myenv_load_scripts $myenv_path/.myenv/source
		fi
	done
}