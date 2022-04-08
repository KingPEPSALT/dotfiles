function ellipsis_cut(){
  [ $(expr length $1) -ge 18 ] && echo "$(echo $1 | cut -c 1-15)..." || echo $1 
}

function np_prompt() {
  if [ ! $(playerctl status -p spotify) ]; then
    return 0
  fi
  state="$([ $(playerctl status -p spotify ) = "Playing" ] && echo " Playing" || echo " Paused")"
  currently="%{$fg_bold[red]%}$(ellipsis_cut "$(playerctl metadata -p spotify title)") %{$fg[white]%}by %{$fg_bold[red]%}$(ellipsis_cut "$(playerctl metadata -p spotify artist)") %{$fg[white]%}in %{$fg_bold[red]%}$(ellipsis_cut "$(playerctl metadata -p spotify album)")"
  echo "%{$fg[white]%}| %{$fg_bold[green]%}$state $currently"
}
PROMPT='%{$fg_bold[red]%}┌[%{$fg_bold[white]%}$(whoami)%{$fg_bold[red]%}@%{$fg_bold[white]%}$(cat /etc/hostname)%{$fg_bold[red]%}] $(np_prompt)
%{$fg_bold[red]%}└[%{$fg[white]%}%c%{$fg_bold[red]%}] >%{$fg_bold[green]%} %{$fg_bold[red]%}$(git_prompt_info)%{$fg_bold[red]%}%{$reset_color%}'


ZSH_THEME_GIT_PROMPT_PREFIX="("
ZSH_THEME_GIT_PROMPT_SUFFIX=")"
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""

RPROMPT='$(git_prompt_status)%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[cyan]%} ✈"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[yellow]%} ✭"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} ✗"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[blue]%} ➦"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[magenta]%} ✂"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[grey]%} ✱"
