# 版本管理
# 这里的版本就是加载某个版本下面的所有脚本。

export MYENV_VERSION_DIR=

# 获取某个配置的版本号。
# $1 
function mysh_version_read_version
{
	echo ""
}

# $1 脚本的总目录
# $2 需要加载的版本
function mysh_version_load_folder()
{
	MYENV_VERSION_DIR="$1/v$2"
	for f in `find ${MYENV_VERSION_DIR} -maxdepth 1 -type f | sort`; do
		source $f
		#echo "==> ${MYENV_VERSION_DIR}/$f"
	done
}
