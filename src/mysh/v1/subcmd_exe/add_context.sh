#!/bin/bash
# -*- coding:utf-8 -*-

# 处理某个目标的菜单
# 模仿图形界面的右键，可以显示目标的处理项目。
# 配置是
# <pattern>:<name>:<action>

source ${MYENV_TOOL_SH_VERSION_SUBCMD_EXE_PATH}/common/_context.sh

function help()
{
	printf "\nmysh add_context <target> <name> <action>\n"
	printf "  add a context to target\n"
	printf "  action=last all arguments\n"
	printf "  example: mysh add_context ./abc.txt rm rm \${TARGET}\n"
	printf "  example: mysh add_context -- ./abc.txt ls ls -hl \${TARGET}\n"
	printf "  example: mysh add_context ./abc.txt ls ls -- -hl '${TARGET}'\n"
	printf " [option]\n"
	printf "  -h/--help: help\n"
}

# 分析参数
OPTS=`getopt -o h --long help -n "$(basename $0)" -- "$@"`
if [ $? != 0 ]; then
	help
	return 1
fi
eval set -- "$OPTS"

while true ; do
	case "$1" in
		-h|--help)
			help
			shift
			exit 0
			;;
		--)
			shift
			break
			;;
		*)
			help
			shift
			exit 1
			;;
	esac
done

if [ $# -le 3 ]; then
	echo "need at least 3 args($*)=$#."
	help
	exit 1
fi

target=$1
name=$2
shift 2

action="$@"

changed_target=$(myenv_get_escape_path $target)

# 删除 "target:name:*"
sed -i "/^${changed_target}:${name}:.*/d" ${CONTEXT_CONFIG_PATH}

echo "${target}:${name}:${action}" >> ${CONTEXT_CONFIG_PATH}
