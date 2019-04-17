# Ask for ssh key only once
alias unlock_keys='eval $(keychain --eval --quiet id_rsa --timeout 20)'

preexec () {
    if [[ $1 =~ "^ssh" ]] || [[ $1 =~ "^scp" ]] || [[ $1 =~ "^git pull" ]] || [[ $1 = "^git push" ]] ; then
        unlock_keys
    fi
}

# Add custom root to path
export PATH=/home/remi/.root/bin:$PATH
alias drop=/home/remi/scripts/drop.sh

# Dotfiles management
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Some prologin tools
export TEXMFCNF=$HOME/.texmf-config/web2c:
alias iorgen='PYTHONPATH=/usr/lib/python37.zip:/usr/lib/python3.7:/usr/lib/python3.7/lib-dynload:/home/remi/.local/lib/python3.7/site-packages:/usr/lib/python3.7/site-packages:/home/remi/code/prologin/iorgen python -m iorgen'

# Display stderr with a custom style
export LD_PRELOAD="/usr/lib/libstderred.so${LD_PRELOAD:+:$LD_PRELOAD}"

bold=$(tput bold || tput md)
red=$(tput setaf 1)

export STDERRED_ESC_CODE=`echo -e "$bold$red"`
export STDERRED_BLACKLIST="^(clang-7,gcc-7)$"

# Call latexmk with dynamic parameters and cleans up at the end
latex-preview() {
    latexmk -pdf -pvc -quiet $1
    latexmk -c
}

# Download audio from a video link with youtube-dl
alias youtube-audio='youtube-dl -x -f bestaudio --audio-format mp3 -o "%(title)s.%(ext)s"'

# A wonderfull function provided by Fardale (c)
meteo () { curl wttr.in/`tr -s ' ' '_' <<< "$*"`; }

# Display banner
WELCOME_LOCKFILE=/tmp/welcome

if ! [ -f $WELCOME_LOCKFILE ] ; then
    touch $WELCOME_LOCKFILE
    cat .welcome
fi

# Allows to edit command in a regular editor
bindkey '^x^e' edit-command-line
bindkey '^xe'  edit-command-line

# Configure history
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=$HISTSIZE

# Minimalist calculator
function pc {
    calc=$*
    python -c "from math import * ; print($calc)"
}

# fzf bindings
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

