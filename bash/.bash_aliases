# aliases: editor
alias vi='nvim'

# pick one or more files with fzf and open in nvim
vpick() {
  command -v fzf >/dev/null 2>&1 || { echo "fzf not found"; return 1; }
  local -a files
  mapfile -d '' files < <(
    fzf -m --print0 --preview='batcat --color=always {}'
  ) || return
  ((${#files[@]})) && nvim "${files[@]}"
}

# aliases: file listing
alias ll='ls -alF'
alias la='ls -A'
alias lr='ls -latr'
alias l='ls -CF'

# aliases: notifications
# Add an "alert" alias for long running commands. Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# aliases: dirs
dash() {
  local path
  path=$(IFS=/; echo "$*")
  cd "/mnt/secure/@home/dashweb/dev/$path"
}
