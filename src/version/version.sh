# 版本管理
# 这里的版本就是加载某个版本下面的所有脚本。

# 加载指定版本文文件夹内所有的脚本文件，按照顺序。
# $1 脚本的总目录
# $2 需要加载的版本
function mysh_version_load_folder()
{
	local version_dir
	version_dir="$1/v$2"
	for f in `find ${version_dir} -maxdepth 1 -type f | sort`; do
		#echo "==> ${version_dir}/$f"
		source $f
	done
}
