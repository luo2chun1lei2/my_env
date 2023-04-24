# my_env 2.0

my_env 缩写为“myenv”，用于辅助管理使用环境。
其中用于调用各种命令的执行，叫做 mysh (=my shell)。

# 适用系统

Linux 系统，具有基本的 BASH 和 Python3 环境。

# 使用方法

## 安装软件

sudo pip2 install pymux
sudo apt install dialog

.bashrc 中加入
export PATH=$PATH:/..../my_env
source /..../my_env/myenv.complete
