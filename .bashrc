# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

num=31
PROMPT_COMMAND='num=`expr 31 + $((num - 30)) % 7`;'
PROMPT_COMMAND="${PROMPT_COMMAND}"'PS1="\[\033[1;${num}m\][\t][\w]\n[\u@\h]\[\033[0m\]$";'

# User specific aliases and functions
alias ls='ls -l --color=auto'
alias ll='ls -alF --color=auto'
alias vi='vim'
alias ..='cd ..'
alias ...='cd ~'
alias s='screen'
alias sl='screen -list'
alias sr='screen -r'
alias pmversion='perl -le '"'"'for $module (@ARGV) { eval "use $module"; print "$module ", ${"$module\::VERSION"} || "not found" }'"'"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
