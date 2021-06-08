
# 接收命令行的参数
# $1 前缀
# $2 支持的命令。format: "xxx xxx xxx"
# $* 命令行
# 每个命令都在一个文件中实现，然后必须实现
#   ${prefix}_xxx_help()
#   ${prefix}_xxx_parse_opts_and_do() $* 剩下的参数
# 必须存在一个命令是 help_help
function myenv_cmd_option_parse_and_do() {
	if [ $# -lt 3 ]; then
		echo "Please input prefix, supported commands and one action at least."
		exit 1
	fi

	local prefix=$1
	shift
	
	local supported_cmd=$1
	shift
	
	for cmd in ${supported_cmd}; do
	#for cmd in ${MYENV_SH_SUPPORT_CMD}; do
		#echo "==>$cmd"
		if [ "$cmd" == "$1" ]; then
			shift
			#echo "${prefix}_${cmd}_parse_opts_and_do $@"
			${prefix}_${cmd}_parse_opts_and_do $@
			return
		fi
	done
	
	# 如果没有找到，就执行帮助!
	${prefix}_help_help
}
