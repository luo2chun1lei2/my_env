## TODO 下面的函数都没有用上！
## 是因为 config.sh 设置的版本，没有用上！


# $1 config 初始化的文件夹
function mysh_config_create()
{
	CONFIG_DIR=$1
	CONFIG_PATH=${CONFIG_DIR}/config.sh

	if [ -f ${CONFIG_PATH} ]; then
		return
	fi
	
	mkdir -p ${CONFIG_DIR}
	touch ${CONFIG_DIR}/config.sh
	echo "#configuration for my_shell" > $1/config.sh
	# TODO config.sh 有什么用？
}

# $1 config 初始化的文件夹
# $2 env name
# $3 version
function mysh_config_create_env()
{
	if [ -f $1/env/$2/version.sh ]; then
		return
	fi
	mkdir -p $1/env/$2
	echo "VERSION=$3" > $1/env/$2/version.sh
}

# $1 config文件的路径
#function mysh_config_load()
#{
#	if [ -f $1 ]; then
#		source $1
#	else
#		echo "Cannot find \"$1\""
#	fi
#}
