#echo ".bashrc was loaded!"
#
## Git auto-complete
#if [ -f ~/.git-completion.bash ]; then
#    source ~/.git-completion.bash
#fi
#
#
## Setting PATH for Python 3.8
#PATH="/Library/Frameworks/Python.framework/Versions/3.8/bin:${PATH}"
#export PATH
#
## Detect which `ls` flavor is in use
#if ls --color > /dev/null 2>&1; then # GNU `ls`
#	colorflag="--color"
#	export LS_COLORS='no=00:fi=00:di=01;31:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'
#else # macOS `ls`
#	colorflag="-G"
#	export LSCOLORS='BxBxhxDxfxhxhxhxhxcxcx'
#fi
#
#
##### ALIASES
#alias ..="cd .."
#alias ...="cd ../.."
#alias ....="cd ../../.."
#alias .....="cd ../../../.."
#alias ~="cd ~" # `cd` is probably faster to type though
#
## List all files colorized in long format
#alias l="ls -lF ${colorflag}"
#
## List all files colorized in long format, excluding . and ..
#alias la="ls -lAF ${colorflag}"
#
## List only directories
#alias lsd="ls -lF ${colorflag} | grep --color=never '^d'"
#
## Always use color output for `ls`
#alias ls="command ls ${colorflag}"
#
## Always enable colored `grep` output
## Note: `GREP_OPTIONS="--color=auto"` is deprecated, hence the alias usage.
#alias grep='grep --color=auto'
#alias fgrep='fgrep --color=auto'
#alias egrep='egrep --color=auto'
#
## Enable aliases to be sudo’ed
#alias sudo='sudo '
#
## Get macOS Software Updates, and update installed Ruby gems, Homebrew, npm, and their installed packages
#alias update='sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup'
#
## Empty the Trash on all mounted volumes and the main HDD.
## Also, clear Apple’s System Logs to improve shell startup speed.
## Finally, clear download history from quarantine. https://mths.be/bum
#alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl; sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"
#
#
## Merge PDF files, preserving hyperlinks
## Usage: `mergepdf input{1,2,3}.pdf`
#alias mergepdf='gs -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile=_merged.pdf'
#
## Lock the screen (when going AFK)
#alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"
#
## Print each PATH entry on a separate line
#alias path='echo -e ${PATH//:/\\n}'
#
##### BASH PROMPT SETTINGS ####
#
#if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
#	export TERM='gnome-256color';
#elif infocmp xterm-256color >/dev/null 2>&1; then
#	export TERM='xterm-256color';
#fi;
#
#prompt_git() {
#	local s='';
#	local branchName='';
#
#	# Check if the current directory is in a Git repository.
#	git rev-parse --is-inside-work-tree &>/dev/null || return;
#
#	# Check for what branch we’re on.
#	# Get the short symbolic ref. If HEAD isn’t a symbolic ref, get a
#	# tracking remote branch or tag. Otherwise, get the
#	# short SHA for the latest commit, or give up.
#	branchName="$(git symbolic-ref --quiet --short HEAD 2> /dev/null || \
#		git describe --all --exact-match HEAD 2> /dev/null || \
#		git rev-parse --short HEAD 2> /dev/null || \
#		echo '(unknown)')";
#
#	# Early exit for Chromium & Blink repo, as the dirty check takes too long.
#	# Thanks, @paulirish!
#	# https://github.com/paulirish/dotfiles/blob/dd33151f/.bash_prompt#L110-L123
#	repoUrl="$(git config --get remote.origin.url)";
#	if grep -q 'chromium/src.git' <<< "${repoUrl}"; then
#		s+='*';
#	else
#		# Check for uncommitted changes in the index.
#		if ! $(git diff --quiet --ignore-submodules --cached); then
#			s+='+';
#		fi;
#		# Check for unstaged changes.
#		if ! $(git diff-files --quiet --ignore-submodules --); then
#			s+='!';
#		fi;
#		# Check for untracked files.
#		if [ -n "$(git ls-files --others --exclude-standard)" ]; then
#			s+='?';
#		fi;
#		# Check for stashed files.
#		if $(git rev-parse --verify refs/stash &>/dev/null); then
#			s+='$';
#		fi;
#	fi;
#
#	[ -n "${s}" ] && s=" [${s}]";
#
#	echo -e "${1}${branchName}${2}${s}";
#}
#
#if tput setaf 1 &> /dev/null; then
#	tput sgr0; # reset colors
#	bold=$(tput bold);
#	reset=$(tput sgr0);
#	# Solarized colors, taken from http://git.io/solarized-colors.
#	black=$(tput setaf 0);
#	blue=$(tput setaf 33);
#	cyan=$(tput setaf 37);
#	green=$(tput setaf 64);
#	orange=$(tput setaf 166);
#	purple=$(tput setaf 125);
#	red=$(tput setaf 124);
#	violet=$(tput setaf 61);
#	white=$(tput setaf 15);
#	yellow=$(tput setaf 136);
#else
#	bold='';
#	reset="\e[0m";
#	black="\e[1;30m";
#	blue="\e[1;34m";
#	cyan="\e[1;36m";
#	green="\e[1;32m";
#	orange="\e[1;33m";
#	purple="\e[1;35m";
#	red="\e[1;31m";
#	violet="\e[1;35m";
#	white="\e[1;37m";
#	yellow="\e[1;33m";
#fi;
#
## Highlight the user name when logged in as root.
#if [[ "${USER}" == "root" ]]; then
#	userStyle="${red}";
#else
#	userStyle="${orange}";
#fi;
#
## Highlight the hostname when connected via SSH.
#if [[ "${SSH_TTY}" ]]; then
#	hostStyle="${bold}${red}";
#else
#	hostStyle="${yellow}";
#fi;
#
## Set the terminal title and prompt.
#PS1="\[\033]0;\W\007\]"; # working directory base name
#PS1+="\[${bold}\]\n"; # newline
#PS1+="\[${userStyle}\]\u"; # username
#PS1+="\[${white}\]"; # at
## PS1+="\[${hostStyle}\]\h"; # host
#PS1+="\[${white}\] in ";
#PS1+="\[${green}\]\w"; # working directory full path
#PS1+="\$(prompt_git \"\[${white}\] on \[${violet}\]\" \"\[${blue}\]\")"; # Git repository details
#PS1+="\n";
#PS1+="\[${white}\]\🍁 \[${reset}\]"; # `$` (and reset color)
#export PS1;
#
#PS2="\[${yellow}\]→ \[${reset}\]";
#export PS2;
