#!/bin/bash
# -*- coding:utf-8 -*-

# 处理某个目标的菜单
# 模仿图形界面的右键，可以显示目标的处理项目。
# 配置是
# <pattern>:<name>:<action>

source ${MYENV_TOOL_SH_VERSION_DIR}/exe/_context.sh

function help()
{
	printf "\nmysh context [target] [name] [option]\n"
	printf "  do action to context to target\n"
	printf " [option]\n"
	printf "  -l/--list : list information of target\n"
	printf "    context : show information of all targets.\n"
	printf "    context <target>: show information of this target.\n"
	printf "    context <target> <name>: show information of action of this target.\n"
}

# 分析参数
OPTS=`getopt -o hl --long help,list -n "$(basename $0)" -- "$@"`
if [ $? != 0 ]; then
	help
	return 1
fi
eval set -- "$OPTS"

OPT_LIST=n
while true ; do
	case "$1" in
		-h|--help)
			help
			shift
			exit 0
			;;
		-l|--list)
			OPT_LIST=y
			shift
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

if [ $OPT_LIST == 'y' ]; then
	find_context $*
else
	TARGET=$1
	find_context $* | while read line; do
		#echo $(eval $(get_action "$line"))
		eval $(get_action "$line")
	done
fi
