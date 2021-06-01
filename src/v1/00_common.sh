# common functions for sub command.

# $1: project name
# Output: 1: OK, 0: error.
function grp_check_project_name
{
    PRJ_NAME=$1
    if [ -f ${GRP_PROJECTS_DIR}/${PRJ_NAME} ]; then
		echo 1
    else
		echo 0
    fi
}


# $1: None
# Ouput: 1:Not set, 0: set, value -> GRP_PROJECT_NAME
function grp_get_current_project()
{
    if [ -f $GRP_FILE_SAVE_CUR_PRJ ]; then
		PRJ_NAME=`cat $GRP_FILE_SAVE_CUR_PRJ`
		FIND=$(grp_check_project_name ${PRJ_NAME})
		if [ $FIND -eq 0 ]; then
			printf "Current project($GRP_PROJECT_NAME) is INVALID.\n"
			return 1
		fi

		GRP_PROJECT_NAME=${PRJ_NAME}
	
		return 0
	
    else
		printf "Not set current project.\n"
		return 1
    fi
}

# $1 = project name
# Ouput: 1:Not set, 0: set, value -> GRP_PROJECT_NAME
function grp_set_current_project()
{
    FIND=$(grp_check_project_name $1)
    if [ $FIND -eq 0 ]; then
      printf "Cannot find config file in \"${GRP_PROJECTS_DIR}/$1\".\n"
      return 1
    fi

    GRP_PROJECT_NAME=$1
    echo "${GRP_PROJECT_NAME}" > ${GRP_FILE_SAVE_CUR_PRJ}

    return 0
}

function grp_load_cur_project()
{
    grp_get_current_project
    
    grp_load_project $GRP_PROJECT_NAME
}

# $1 = project name
function grp_load_project()
{
    PRJ_NAME=$1

    set -a # 此后脚本中所有set 的变量都是export的。
    source ${GRP_PROJECTS_DIR}/${PRJ_NAME}
    set +a

    SELF_CONFIG="${GRP_PROJECTS_DIR}/${PRJ_NAME}.self"
    if [ -f ${SELF_CONFIG} ]; then
	set -a
	source ${SELF_CONFIG}
	set +a
    fi
}

# 显示某个配置的最终结果
# $1 = project name
# return None
function grp_show_result_of_current_project()
{
    grp_load_cur_project
    env | grep GRP_
}

# 显示某个配置的最终结果
# $1 = project name
# return None
function grp_show_result_of_project()
{
    grp_load_project $1
    env | grep GRP_
}

# CONDITION: GRP_SCRIPT_VERSION
function grp_init_on_version()
{
    if [ -z "${GRP_SCRIPT_VERSION}" ]; then
      printf "The GRP_SCRIPT_VERSION is not set in ${GRP_PROJECT_AND_SUB}.\n"
      exit 1
    fi

    INIT_SCRIPT_PATH=${GRP_SCRIPT_DIR}/v${GRP_SCRIPT_VERSION}/_init.sh
    if [ ! -f "${INIT_SCRIPT_PATH}" ]; then
      printf "Cannot find \"${INIT_SCRIPT_PATH}\".\n"
      exit 1
    fi

    source ${INIT_SCRIPT_PATH}

}

function grp_deinit_on_version()
{
    DEINIT_SCRIPT_PATH=${GRP_SCRIPT_DIR}/v${GRP_SCRIPT_VERSION}/_deinit.sh
    if [ ! -f "${DEINIT_SCRIPT_PATH}" ]; then
      printf "Cannot find \"${DEINIT_SCRIPT_PATH}\".\n"
      exit 1
    fi

    source ${DEINIT_SCRIPT_PATH}
}
