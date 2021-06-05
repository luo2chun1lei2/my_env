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
