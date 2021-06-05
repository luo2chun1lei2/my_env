
# 接收命令行的参数
# $* 命令行
# MYENV_SH_SUPPORT_CMD "xxx xxx xxx"
# 每个命令都在一个文件中实现，然后必须实现
#   xxx_help()
#   xxx_parse_opts_and_do() $* 剩下的参数
# 必须存在一个命令是 help_help
function myenv_cmd_option_parse_and_do() {
	if [ $# -eq 0 ]; then
		echo "Please input one action and options."
		exit 1
	fi

	for cmd in ${MYENV_SH_SUPPORT_CMD}; do
		#echo "==>$cmd"
		if [ "$cmd" == "$1" ]; then
			shift
			#echo "${cmd}_parse_opts_and_do $@"
			${cmd}_parse_opts_and_do $@
			return
		fi
	done
	
	# 如果没有找到，就执行帮助!
	help_help
}
