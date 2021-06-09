
# 接收命令行的参数
# $1 前缀
# $2 支持的命令。format: "xxx xxx xxx"
# $* 命令行
# 每个命令都在一个文件中实现，然后必须实现
#   ${prefix}_xxx_help()
#   ${prefix}_xxx() $* 剩下的参数
# 必须存在一个命令是 help_help
function myenv_cmd_option_parse_and_do() {
#set -x
	if [ $# -lt 3 ]; then
		echo "Please input prefix, supported commands and one action at least."
		return
	fi

	local prefix=$1
	shift
	
	local supported_cmd=$1
	shift
	
	for one in ${supported_cmd}; do
		#echo "==>$cmd"
		local cmd
		local cmd_path
		if [[ $one =~ .*:.* ]]; then
			cmd=${one%:*}
			cmd_path=${one#*:}
		else
			cmd=$one
			cmd_path=
		fi
		
		if [ "$cmd" == "$1" ]; then
			shift
			#echo "${prefix}_${cmd} $@"
			if [ -n "$cmd_path" ]; then
				${cmd_path} $@
			else
				${prefix}_${cmd} $@
			fi
			return
		fi
	done
	
	# 如果没有找到，就执行帮助!
	echo "Cannot find command($1)."
	${prefix}_help_help
#set +x
}
