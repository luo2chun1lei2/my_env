## TODO 下面的函数都没有用上！
## 是因为 config.sh 设置的版本，没有用上！

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
	touch ${CONFIG_DIR}/config.sh
	# 文件的内容由用户自己填写。
	
	return 0
}
