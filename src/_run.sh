# 运行当前项目的一个命令。
# 1. 运行命令之前加载当前项目对应版本的 init.sh 脚本。
# 2. 运行命令
# 3. 运行命令后，运行当前项目对应的版本的 deinit.sh 脚本。

function grp_run()
{
    grp_load_cur_project
    
    grp_init_on_version

    # 在每个版本中自行实现的。
    grp_version_run $@

    # TODO: 暂时没有用处！
    #grp_deinit_on_version
}
