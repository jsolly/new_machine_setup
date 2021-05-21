# %B means make text BOLD
# %F is the way you change colors
# %n is the username of the currently logged in user
# %1~ shows the current directory
# %D shows the date
PS1='🍁%B%F{cyan}%n%f%b:%D:%F{green}%1~%f ~ $ '

# Load Git completion
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
fpath=(~/.zsh $fpath)

autoload -Uz compinit && compinit


