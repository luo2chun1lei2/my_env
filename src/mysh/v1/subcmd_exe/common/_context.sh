
source ${MYENV_TOOL_SRC_PATH}/common/utils/utils.sh

CONTEXT_CONFIG_PATH=${MYENV_CUR_CONFIG_DATA_PATH}/context.txt

# [$1] target
# [$2] name
function find_context()
{
	local pattern
	if [ $# -eq 0 ]; then
		pattern=".*"
	elif [ $# -eq 1 ]; then
		pattern="^$1:.*"
	elif [ $# -eq 2 ]; then
		pattern="^$1:$2:.*"
	fi
	
	# 不能用 for，这个读取后，每行还以“空格”来分给每行
	local index=0
	local found=()
	#declare -a found
	grep "${pattern}" ${CONTEXT_CONFIG_PATH} 2>/dev/null | while read line; do
		#found[$index]=$line
		#let index++
		echo $line
	done
	#echo ${found[*]}
	for o in ${found[*]}; do
		echo $o
	done
}

# $1 一行信息
function get_action()
{
	local name_action=${1#*:}
	local action=${name_action#*:}
	echo $action
}

function get_target()
{
	echo ${1%%:*}
}
