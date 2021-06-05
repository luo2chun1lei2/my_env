# 放一些共通的模块，杂七杂八的东西。

# $1 : path
function myenv_get_full_path()
{
	if [ -d "$1" ]; then
		echo "$(cd "$1" && pwd)"
	elif [ -f $1 ]; then
		FN=`basename $1`
		echo "$(cd "$(dirname "$1")" && pwd)/$FN"
	fi
	echo
}

# 经过判断才创建文件，避免修改文件的时间.
# $1 path
function myenv_create_file()
{
	if [ ! -f $1 ]; then
		touch $1
	fi
}

# 经过判断才创建文件夹
# $1 path
function myenv_create_dir()
{
	if [ ! -d $1 ]; then
		mkdir -p $1
	fi
}
