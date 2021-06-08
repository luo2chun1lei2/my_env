# mysh 是一个function，不再是一个独立的程序，
# 因为 mysh 的一部分功能需要改变当前的环境，只有是一个function才可以实现。
# 不过 mysh 也可以调用其他的程序。
# 提供给 mysh <command> 用。

# 必须作为第一个开始的脚本。

MYENV_SH_SUPPORT_CMD=
