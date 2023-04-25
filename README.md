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
export PATH=$PATH:<my_env>
source <my_env>/myenv.complete

## 使用方法

先通过 myenv 设置和进入到某个特定的环境中，
然后再用 mysh 执行一些特定的动作，实现重要的功能。

我目前最想要的就是，
1. 要初始化一些环境，必须自动化进入的脚本。
2. 加入一些快捷的命令，比如 别名、函数。
3. 进入到环境中后，可以设置各种跳转的路径，这样方便跳转，然后可以记录跳转的记录，这样能够来回跳转。
4. 记录文件和标签绑定，根据标签来列举重要的文件。
5. 用 tmux 来实现多个屏幕，然后可以显示多个标签对应不同的屏幕。
6. 可以保存命令执行的结果，以及对命令结果进行再处理。