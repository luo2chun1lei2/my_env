# list env name.
function grp_list()
{
    PROJECT_NAME_PATTERN=$1

    if [ -z "$PROJECT_NAME_PATTERN" ]; then
		# list all projects
		(cd ${GRP_PROJECTS_DIR} && find -type f | grep -v "\.self" | sed 's/^\.\///' )
    else
		# list project by project name pattern.
		(cd ${GRP_PROJECTS_DIR} && find -type f -name "${PROJECT_NAME_PATTERN}" | sed 's/^\.\///' )
    fi
}
