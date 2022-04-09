function ellipsis_cut(){
  [ $(expr length $1) -ge 15 ] && echo "$(echo $1 | cut -c 1-12)..." || echo $1 
}

function spotify_now_playing_prompt() {
  if [ ! $(playerctl status -p spotify) ]; then
    return 0
  fi
  state="$([ $(playerctl status -p spotify ) = "Playing" ] && echo " Playing" || echo " Paused")"
  artist="$(playerctl metadata -p spotify artist 2> /dev/null)"
  if [[ -z $artist ]]; then
    currently="%{$fg_bold[white]%}Podcast %{$fg_bold[cyan]%}$(ellipsis_cut "$(playerctl metadata -p spotify title)") %{$fg[white]%}- %{$fg_bold[cyan]%}$(ellipsis_cut "$(playerctl metadata -p spotify album)")"
  else # likely a podcast
    currently="%{$fg_bold[cyan]%}$(ellipsis_cut "$(playerctl metadata -p spotify title)") %{$fg[white]%}by %{$fg_bold[cyan]%}$(ellipsis_cut "$(playerctl metadata -p spotify artist)") %{$fg[white]%}in %{$fg_bold[cyan]%}$(ellipsis_cut "$(playerctl metadata -p spotify album)")"
  fi
  echo "%{$fg[white]%}| %{$fg_bold[green]%}$state $currently"
}
PROMPT='%{$fg_bold[blue]%}┌[%{$fg_bold[white]%}$(whoami)%{$fg_bold[blue]%}@%{$fg_bold[white]%}$(cat /etc/hostname)%{$fg_bold[blue]%}] $(spotify_now_playing_prompt)
%{$fg_bold[blue]%}└[%{$fg[white]%}%c%{$fg_bold[blue]%}] >%{$fg_bold[green]%} %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%}%{$reset_color%}'


ZSH_THEME_GIT_PROMPT_PREFIX="("
ZSH_THEME_GIT_PROMPT_SUFFIX=")"
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""

RPROMPT='$(git_prompt_status)%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[cyan]%} ✈"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[yellow]%} ✭"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[blue]%} ✗"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[blue]%} ➦"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[magenta]%} ✂"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[grey]%} ✱"
