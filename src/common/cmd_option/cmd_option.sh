
# 根据参数找到需要执行的程序
# 1： 来自于"独立运行程序"，需要 subcmd 的名字和文件名字（去掉后缀）对应。
#  每个程序都必须支持 -h/--help 帮助。
#  然后执行是 $<name>.? $*
# 2： 来自于"内部function"，需要支持 $prefix_$name() & $prefix_$name_help() 这两个函数。
# 每个命令都在一个文件中实现，然后必须实现
#   ${prefix}_xxx_help()
#   ${prefix}_xxx() $* 剩下的参数
# 必须存在一个命令是 help_help
# $1 独立运行程序所在文件夹的路径
# $2 function的前缀
# $3 支持的function的名字部分。format: "xxx xxx xxx"
# $* 参数！

function myenv_cmd_option_parse_and_do() {
#set -x
	if [ $# -lt 4 ]; then
		echo "Please input exe dir path, prefix, supported commands and one action at least."
		return
	fi

	local exe_path=$1
	shift

	local prefix=$1
	shift
	
	local supported_cmd=$1
	shift

	local cmd=$1
	shift
	
	for one in ${supported_cmd}; do
		#echo "==>$cmd"

		# 先执行内部的function
		if [ "$cmd" == "$one" ]; then
			${prefix}_${cmd} $@
			return 0
		fi
	done

	# 再找独立运行程序
		if [ -n "${exe_path}" -a -d ${exe_path} ]; then
			for f in `find $exe_path -maxdepth 1 -type f  | sort`; do
				name=$(basename $f)
				just_name=${name#*.}
				if [ "$just_name" == "$cmd" ]; then
					$f $@
					return 0
				fi
			done
		fi
	
	# 如果没有找到，就执行帮助!
	echo "Cannot find command($cmd)."
	${prefix}_help_help

	return 1
#set +x
}
