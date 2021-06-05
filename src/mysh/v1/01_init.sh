# 初始化系统，不需要单独运行。

function v1_help()
{
    printf 'VESION 1:\n'
    printf '  Just get/build/test/release old system.\n'
    
    printf '\n  help\n'
    printf '    show help\n'

    printf '\n  init\n'
    printf '    download source and tools if new. Otherwise do nothing.\n'
    
    printf '\n  build\n'
    printf '    XXXXXX.\n'
    
    printf '\n  test [tag]\n'
    printf '    test this project.\n'
    printf '    [tag]     XXXXXX.\n'

    printf '\n  release\n'
    printf '    create release things to customizer.\n'
}

function v1_init()
{
    if [ -z "${GRP_SRC_NEBULA_PARENT_DIR}" ]; then
		echo "GRP_SRC_NEBULA_PARENT_DIR is not set in project file."
		exit 1
    fi

    if [ -d "${GRP_SRC_NEBULA_DIR}" ]; then
		echo "Folder \"${GRP_SRC_NEBULA_DIR}\" existed, please remove it or change dir."
		return
    fi

    if [ -z "${GRP_SRC_NEBULA_GET_CMD}" ]; then
		echo "GRP_SRC_NEBULA_GET_CMD shall be set for getting source of NEBULA."
		exit 1
    fi

    echo "Start get source of NEBULA......"

    mkdir -p ${GRP_SRC_NEBULA_PARENT_DIR}
    (cd ${GRP_SRC_NEBULA_PARENT_DIR} && eval ${GRP_SRC_NEBULA_GET_CMD})

    echo "Start get source of ALPS......"

    echo "Start get source of GX-DEV......"
}


# 必须实现！
# $1... 参数
# OUTPUT: 无所谓。
function grp_version_run()
{

    case "$1" in
    help)
	shift
	v1_help $@
	exit 0;;
    init)
	shift
	v1_init $@
	exit 0;;
    build)
	shift
	v1_build $@
	exit 0;;
    test)
	shift
	v1_test $@
	exit 0;;
    release)
	shift
	v1_release $@
	exit 0;;
    *)
	v1_help 1>&2 ; exit 1;;
    esac

#TODO: 下面没有用！
    ARGS=`getopt -o e:s --long exe:,show -- "$@"`

    eval set -- "${ARGS}"

    while true; do
	case "$1" in
	    -s|--show)
		usage
		exit 0;;
	    -l|--list)
		JUST_LIST_CONFIG=y
		shift
		;;
	    -e|--exe)
		EXE="$2"
		shift 2
		;;
	    --)
		shift; break;;
	    *)
		usage 1>&2 ; exit 1;;
	esac
    done

    if [ $# -eq 0 ]; then
	# show current project.
	grp_get_current_project
    elif [ $# -eq 1 ]; then
	grp_set_current_project $1
    else
	printf 'Current project only must be ONE.\n'
	usage
	exit 1
    fi
}
