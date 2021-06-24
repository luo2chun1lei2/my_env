# 没有具体的功能，琐碎的函数

# 得到绝对路径。
# 可以用 realpath $1 来实现。
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

# 得到路径相对于 from directory 的路径。
# $1 from directory
# $2 path
function myenv_get_rlt_path()
{
	if [ ! -d $1 ]; then
		echo "1"
		return
	fi

	if [ ! -d $2 -a ! -f $2 ]; then
		echo "2"
		return
	fi

	realpath --relative-to $1 $2

}

# 根据path，生成缩略路径
# $1 : path
function myenv_get_abbr_path()
{
	base1=$(basename $1)
	base2=$(basename $(dirname $1))
	echo "$base2/$base1"
}
export -f myenv_get_abbr_path

# 变成 sed 可以用的 path
# $1 path
function myenv_get_escape_path()
{
	echo $1 | sed 's/\//\\\//g'
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
