
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