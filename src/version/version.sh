# 版本管理
# 这里的版本就是加载某个版本下面的所有脚本。

export MYSH_VERSION_DIR=

# $1 脚本的总目录
# $2 需要加载的版本
function mysh_version_load_folder()
{
	MYSH_VERSION_DIR="$1/v$2"
	for f in `find ${MYSH_VERSION_DIR} -maxdepth 1 -type f | sort`; do
		source $f
		#echo "==> ${MYSH_VERSION_DIR}/$f"
	done
}
