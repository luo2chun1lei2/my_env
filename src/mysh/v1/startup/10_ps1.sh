# below are the customized settings.

function mysh_prompt()
{
    info=""
    
    if [ -n "${MYENV_CUR_NAME}" ]; then
		info="${info}ENV:${MYENV_CUR_NAME} "
	else
		info="${info}ENV:$(myenv_get_abbr_path ${MYENV_CUR_PATH}) "
	fi

    info="${info}SH:${SHLVL} "

    # find ss-local
    ss_pid=`pidof ss-local 2>/dev/null`
    if [ -n "$ss_pid" ]; then
        local cmd=`ps -q ${ss_pid} -o args= | awk '{print $3}'`
        info="${info}CNT=${cmd##*\.} "
    else
        info="${info}CNT=OFF "
    fi

    # show proxy
    if [ -n "$http_proxy" ]; then
        info="${info}PROXY=ON "
    else
        info="${info}PROXY=OFF "
    fi

    echo "$info"
}

# 参考 http://billie66.github.io/TLCL/book/chap14.html
#color "\[\e[S;F;Bm\]", "\[\e[0m\]" 取消颜色。
#前景F 背景B 颜色
#30 40 黑色
#31 41 红色
#32 42 绿色
#33 43 黃色
#34 44 蓝色
#35 45 紫紅色
#36 46 青蓝色
#37 47 白色
# S: 0、 1、  22、   4、    24、     5、  25、    7、  27
# 默认值、粗体、非粗体、下划线、非下划线、闪烁、非闪烁、 反显、非反显。

#PS1='\342\224\214 \[\e[1;37;42m\][#\#@\!| \t| JOB:\j| \w]\[\e[0m\]\n\342\224\224 `if [ $? -eq 0 ]; then echo -n O; else echo -n X; fi;` $(mysh_prompt)\n\$ '
# 这里必须用单引号，否则"$?"就无法推迟到显示时才执行。
MYENV_CMD_RLT='`if [ $? -eq 0 ]; then echo -n "\[\e[1;37;42m\]O\[\e[0m\]"; else echo -n "\[\e[1;37;41m\]X\[\e[0m\]"; fi;`'
MYENV_PROMPT='$(mysh_prompt)'
PS1="\342\224\214 $MYENV_CMD_RLT \[\e[1;37;42m\][#\#@\! \t JOB:\j \u@\h:\w]\[\e[0m\]\n\342\224\224   \[\e[1;37;43m\]$MYENV_PROMPT\[\e[0m\]\n\$ "

# 命令输入后，执行前的输出。可以作为命令执行时间的标志。
# TODO: 加入颜色后前后不知道为什么有特殊字符显示。只要不加入颜色就可以。
#PS0="\[\e[1;37;42m\] \t \[\e[0m\]\n"
PS0="<<< \t >>>\n"
