# $0 是程序的名字.
function myenv_help()
{
	printf "%s [options] [env name/path]\n" `basename $0`
	printf "    env name is set in ~/.myenv/map_name_path.\n"
	printf "    Or there is .myenv in Path.\n"
	printf "    If empty, find nearest .myenv in up directory.\n"
	printf "  options:\n"
	printf "    -c/--create : create a env by path or current pwd.\n"
	printf "    -n/--name <name> : set name to path.\n"
}

# 环境所在的目录
export MYENV_CUR_PATH=
# 环境的名字
export MYENV_CUR_NAME=

# 生成用户的环境配置文件
# 每次都强制执行，这样配置文件都是全的。
myenv_create_env_of_user

# 加载工具本身的配置
#source ${MYENV_TOOL_SRC_PATH}/env/pre_env.sh
# 加载user环境中的配置
#source ${MYENV_CUR_CONFIG_PATH}

# 分析参数
OPTS=`getopt -o hcn: --long help,create,name: -n "$(basename $0)" -- "$@"`
if [ $? != 0 ]; then
	myenv_help
	exit 1
fi
eval set -- "$OPTS"

# 环境的名字或者路径
OPT_INPUT=
# 是否创建环境
OPT_CREATE=
# 设置环境的名字
OPT_SET_NAME=

while true ; do
	case "$1" in
		-h|--help)
			myenv_help
			exit 0 ;;
		-c|--create)
			OPT_CREATE=y
			shift ;;
		-n|--name)
			OPT_SET_NAME=$2
			shift 2;;
		--) shift ; break ;;
		*)
			myenv_help
			exit 1 ;;
	esac
done

#echo "Remaining arguments:"
#for arg in $*; do
#   echo '--> '"\`$arg'" ;
#done

if [ $# -gt 1 ]; then
	myenv_help
	exit 1
fi

if [ $# -eq 1 ]; then
	OPT_INPUT=$1
fi

if [ "$OPT_CREATE" == 'y' ]; then
	# 如果要创建环境
	if [ -n "${OPT_INPUT}" ]; then
		MYENV_CUR_NAME=
		MYENV_CUR_PATH="${OPT_INPUT}"

		if [ -d ${MYENV_CUR_PATH} ]; then
			MYENV_CUR_PATH=$(myenv_get_full_path ${MYENV_CUR_PATH})
		else
			exit 1
		fi
		
	else
		MYENV_CUR_NAME=
		MYENV_CUR_PATH=$(pwd)
	fi

	myenv_create_env_by_path ${MYENV_CUR_PATH}
	if [ $? -ne 0 ]; then
		exit 1
	fi
else
	# 如果要加载环境
	if [ -n "$OPT_INPUT" ]; then
		# Input 按照名字来分析
		MYENV_CUR_NAME="${OPT_INPUT}"
		MYENV_CUR_PATH=$(myenv_find_env_path_by_name ${MYENV_CUR_NAME})
		MYENV_CUR_PATH=$(myenv_check_env_path ${MYENV_CUR_PATH})

		if [ -z "${MYENV_CUR_PATH}" ]; then
			# Input不是名字，当做路径
			MYENV_CUR_NAME=
			MYENV_CUR_PATH=$(myenv_check_env_path ${OPT_INPUT})

			if [ -z "${MYENV_CUR_PATH}" ]; then
				# 还是无法定位环境
				echo "Input is not a name or valid path."
				exit 1
			else
				MYENV_CUR_PATH=$(myenv_get_full_path ${MYENV_CUR_PATH})
			fi
		fi
	else
		# 没有Input，就找最近的环境
		MYENV_CUR_NAME=
		MYENV_CUR_PATH=$(myenv_find_nearest_env_path $(pwd))
		if [ -z "${MYENV_CUR_PATH}" ]; then
			echo "Cannot find one valid env."
			exit 2
		fi
	fi
fi

# 设定环境的名字
if [ -n "${OPT_SET_NAME}" ]; then
	MYENV_CUR_NAME=$OPT_SET_NAME
	myenv_set_name_of_env_path $OPT_SET_NAME $MYENV_CUR_PATH
	if [ $? -ne 0 ]; then
		exit 1
	fi
fi

echo "MY ENV NAME=${MYENV_CUR_NAME}, PATH=${MYENV_CUR_PATH}"
