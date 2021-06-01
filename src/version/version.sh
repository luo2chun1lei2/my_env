# 版本管理
# 这里的版本就是加载某个版本下面的所有脚本。

MYSH_VERSION=
MYSH_LOADER_DIR=

# $1 脚本的总目录
# $2 需要加载的版本
function mysh_version_load_folder()
{
	for f in `ls $1/$2 | sort`; do
		echo "--> $f"
	done
}
