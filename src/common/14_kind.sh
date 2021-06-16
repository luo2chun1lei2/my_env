# 类型

# 获取带有类型的目录。
# 作为统一的文件路径拼凑函数。
# $1 脚本的总目录
# $2 类型
function myenv_kind_get_folder()
{
	echo "$1/k$2"
}

# 根据文件获取kind信息
# 文件的格式是内部有一个文字，就是kind。
# 这样格式就不依赖于特定的工具和语言。
# $1 file path
# $2 default value
function myenv_kind_get_by_file()
{
	if [ -f $1 ]; then
		echo $2
	fi

	local kind=$(cat $1)
	if [ -z "$kind" ]; then
		return $2
	fi

	echo $1
}
