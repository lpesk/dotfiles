# editor
export EDITOR=emacs

# aliases
alias ls='ls -a --color'

# git
autoload -Uz compinit && compinit
## thx https://artyom.dev/zsh.html
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' formats ' %F{cyan}(%b)%f'
zstyle ':vcs_info:*' actionformats ' %F{cyan}(%b|%a)%f'
precmd () { vcs_info; printf '\e]7;%s\a' $PWD; }

# go to paths, no `cd` needed
setopt AUTO_CD
# suggest alternatives to unrecognized commands
setopt CORRECT
# allow substitutions in prompt
setopt PROMPT_SUBST

# prompt
PROMPT='%F{magenta}%~${vcs_info_msg_0_} %F{yellow}»%f '

