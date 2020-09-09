# Common variables
export EDITOR="nvim"
export GPG_TTY=$(tty)
export PATH=/home/remi/.root/bin:/home/remi/.cargo/bin:/home/remi/.local/bin:$PATH
# export RUSTC_WRAPPER=/home/remi/.cargo/bin/sccache

# Node version management
source /usr/share/nvm/init-nvm.sh

# Common aliases
alias vim="nvim"  # use nvim by default
alias config="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME" # dotfiles management

# gh cli completion
eval "$(gh completion -s zsh)"

# Ask for ssh key only once
alias unlock_keys='eval $(keychain --eval --quiet id_rsa --timeout 20)'

preexec () {
    if [[ $1 =~ "^ssh" ]] || [[ $1 =~ "^scp" ]] || [[ $1 =~ "^git pull" ]] || [[ $1 = "^git push" ]] ; then
        unlock_keys
    fi
}

alias drop=/home/remi/scripts/drop.sh

# Some prologin tools
export TEXMFCNF=$HOME/.texmf-config/web2c:
alias iorgen='PYTHONPATH=/usr/lib/python37.zip:/usr/lib/python3.7:/usr/lib/python3.7/lib-dynload:/home/remi/.local/lib/python3.7/site-packages:/usr/lib/python3.7/site-packages:/home/remi/code/prologin/iorgen python -m iorgen'

# Display stderr with a custom style
export LD_PRELOAD="/usr/lib/libstderred.so${LD_PRELOAD:+:$LD_PRELOAD}"

# In particular, libpostal doesn't install in usual directories
export LD_LIBRARY_PATH="/usr/local/lib:$LD_LIBRARY_PATH"

bold=$(tput bold || tput md)
red=$(tput setaf 1)

export STDERRED_ESC_CODE=`echo -e "$bold$red"`
export STDERRED_BLACKLIST="^(clang-7,gcc-7)$"

# Call latexmk with dynamic parameters and cleans up at the end
latex-preview() {
    latexmk -shell-escape -pdf -pvc -quiet $1
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
    python -c "from math import * ; print($*)"
}

# fzf bindings
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Perl configuration
PATH="/home/remi/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/remi/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/remi/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/remi/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/remi/perl5"; export PERL_MM_OPT;
