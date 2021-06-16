# 加载脚本类的工具都在这里。

# $1: path
# $*: parameter
function myenv_load_scripts()
{
	if [ ! -d $1 ]; then
		return 1
	fi
	local dir=$1
	shift
	
	local opts="$*"
	
	for f in `find $dir -maxdepth 1 -type f  | sort`; do
		source $f $opts
	done

	return 0
}

export -f myenv_load_scripts

# Just set path to bin
# $1: path
function myenv_load_bin_to_path()
{
	if [ ! -d $1 ]; then
		return 1
	fi
	
	export PATH=$PATH:$1

	return 0
}

# 加载文件夹中的exe程序，作为子命令。
# 1. 所有的exe程序都必须可以执行。
# 2. 必须支持 command -h
# $1: path
# return: "<command>:<path> ..."
function myenv_load_exe()
{
	if [ ! -d $1 ]; then
		return 1
	fi
	local dir=$1

	local list=""
	for f in `find $dir -type f | sort`; do
		list="${list} $(basename $f):$(myenv_get_full_path $f)"
	done

	echo $list
}

# $1 "<command>:<path> ..."
# $2 command
function myenv_invoke_exe()
{
	local list=$1
	local exe=$2
	shift 2
	
	local cmd
	local path
	for cmd_path in $list; do
		cmd=${cmd_path%:*}
		path=${cmd_path#*:}
		if [ "${cmd}" == "$exe" ]; then
			$(path) $*
			return 0
		fi
	done
	
	return 1
}

# $1 cmd
# $* 列表
function myenv_get_path_by_cmd()
{
	cmd=$1
	shift
	
	local cmd_path=
	
	for one in $*; do
		if [[ $one =~ .*:.* ]]; then
			one_cmd=${one%:*}
			one_path=${one#*:}
		else
			one_cmd=$one
			one_path=$one
		fi
		
		if [ "$one_cmd" == "$cmd" ]; then
			echo $one_path
			return
		fi
	done

	echo ""
}
