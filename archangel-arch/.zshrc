export ZSH="$HOME/.oh-my-zsh"

CASE_SENSITIVE="true"
COMPLETION_WAITING_DOTS="true"
plugins=(git)
ZSH_THEME="archangel"

source $ZSH/oh-my-zsh.sh
export LANG=en_.UTF-8
export ARCHFLAGS="-arch x86_64"

# yanks (copies) a file into the clipboard
function yank(){
  if [ ! $1 ]; then
    echo "\e[1;31mIncorrect usage\e[0m - try: yank \e[0;34m[filename]\e[0m"
    return 1
  fi
  xclip -selection clipboard $1 -i 2> /dev/null \
    && echo "Successfully copied \e[1;32m$1\e[0m to clipboard" \
    || (echo "Failed to copy \e1[;31m$1\e[0m to clipboard"; return 1)
}


# shows content in all X selections, ususally for debugging
function xclipview(){
  for l in "clipboard" "primary" "secondary" "buffer-cut" do
    echo "\e[1;33m_$l\e[0m: $(xclip -sel _$l -o)\n"
}

function crunchyroll_title(){
  playerctl status -p firefox.instance1464 &> /dev/null && \
    echo "\e[1;33mWatching \e[0m$(echo "$(playerctl metadata -p firefox.instance1464 title)" | cut -f 1 -d "-")"
}



# ------------------------------------------- #
# playerctl spotify controls with nice output #
# ------------------------------------------- #

# displays current playing song
function sptnw(){
  playerctl status -p spotify &> /dev/null && (IFS='|' read -A metadata <<< $(playerctl metadata -p spotify -f "{{title}}|{{artist}}|{{album}}") \
      ; echo " \e[1;31m${metadata[1]}\e[0m by \e[1;31m${metadata[2]}\e[0m on \e[1;31m${metadata[3]}\e[0m") \
    || (echo "Spotify is \e[1;31mnot\e[0m active."; return 1)
}
# plays/pauses current song with pretty output
function sptpl(){
  playerctl status -p spotify &> /dev/null && (playerctl play-pause -p spotify; \
    ; echo "\e[1;32m$([ $(playerctl status -p spotify) = "Playing" ] && echo " Paused" || echo " Playing")\e[0m song \e[1;31m$(playerctl metadata -p spotify title)\e[0m") \
    || (echo "Spotify is \e[1;31mnot\e[0m active."; return 1)
}

alias cfg="cd $XDG_CONFIG_HOME"
alias v="nvim"
alias cdev="cd ~/documents/dev"
alias sz="source ~/.zshrc"
alias vz="nvim ~/.zshrc"
alias sv="sudo nvim"

source ~/clones/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

