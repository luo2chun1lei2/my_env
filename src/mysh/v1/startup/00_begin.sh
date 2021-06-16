# 脚本，提供给 shell 中用的函数等功能，不是给 myenv 用的。

# 不用 .bashrc，因为环境变量都传入了。
# [BUG: 如果这里自己 引入 .bashrc，那么输入 xxx.xx 后按TAB会错误。
# 如果只是敲入 bash，不会出现上面的问题，原因不明！]
# 但是alias 需要自己再设置。

#source $HOME/.bashrc

alias up='cd ..'
alias up2='cd ..; cd ..'
alias up3='cd ..; cd ..; cd ..'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
