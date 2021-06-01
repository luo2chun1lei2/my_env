# 显示帮助信息。
function usage()
{
    PRG_NAME=$(basename "$0")

    printf '%s, assist to manage environment:\n' ${PRG_NAME}
    printf '  Do action by different version.\n'
    
    printf '\n%s: help\n' ${PRG_NAME}
    printf '  show help\n'
    
    printf '\n%s: list [project name pattern]\n' ${PRG_NAME}
    printf '  list all projects or some project by name pattern (such as abc*).\n'
    
    printf '\n%s: set [project name]\n' ${PRG_NAME}
    printf '  set current project. if not set project, then show current project.\n'
    printf '  [project name]  project used, such as ecarx/ecarx in project list.\n'
    printf '  -s/--show     Show result after loading config.\n'

    printf '\n%s: run command\n' ${PRG_NAME}
    printf '  run command of current project.\n'
}
