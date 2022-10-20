# Update $PATH environment variable
fish_add_path /home/remi/.local/bin
fish_add_path /home/remi/.cargo/bin
fish_add_path /home/remi/.nvm/versions/node/v16.3.0/bin

# GPG command line utility suffers from some sort of conflict with stderred, we
# just need to disable it while running.
alias gpg="LD_PRELOAD=\"\" /usr/bin/gpg"

# eval (ssh-agent -c)

fish_default_key_bindings -M insert
fish_vi_key_bindings --no-erase insert

bind \cz fg
bind -M insert \cn "nicer; commandline -f repaint"

starship init fish | source

{% if env.nvm.enabled %}
    load_nvm
{% endif %}

## FZF settings & functions for fish; collected with attribution and modified.

# These rely on `git lg`; from git's config:
#     lg             = log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'
# They also rely on the following being installed:
# - bat
# - delta
# - exa
# - fd
# - rg

# https://github.com/jethrokuan/fzf
# https://github.com/junegunn/fzf#respecting-gitignore
# We want hidden but not `.git` paths
set -gx FZF_DEFAULT_COMMAND 'fd --hidden --follow --exclude="**/.git/"'
# https://github.com/junegunn/fzf/wiki/Examples#clipboard
set -gx FZF_DEFAULT_OPTS '--height 40% --layout=reverse --color=light --bind "ctrl-y:execute-silent(printf {} | cut -f 2- | pbcopy),ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down"'
set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND "--type f"
set -gx FZF_CTRL_T_OPTS "--preview 'bat --style=numbers --color=always {} | head -500'"
set -gx FZF_ALT_C_COMMAND $FZF_DEFAULT_COMMAND "--type d"
set -gx FZF_ALT_C_OPTS "--preview 'exa -T {} | head -200'"
# https://github.com/junegunn/fzf/wiki/Configuring-shell-key-bindings
set -gx FZF_CTRL_R_OPTS "--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"

# Heavily adapted & simplified from:
# https://github.com/junegunn/fzf/wiki/Examples-(fish)#navigation
function fzf-cdhist-widget -d 'cd to one of the previously visited locations'
  if [ -z "$dirprev" ]
    return
  end
  # TODO @max: Can we re-include git-ignored folders?
  string join \n $dirprev | tac | eval (__fzfcmd) +m --tiebreak=index --toggle-sort=ctrl-r $FZF_CDHIST_OPTS | read -l result
  [ "$result" ]; and cd $result
  commandline -f repaint
end
bind \cb fzf-cdhist-widget
bind -M insert \cb fzf-cdhist-widget


# Significantly adjusted to fish from
# https://github.com/junegunn/fzf/wiki/Examples#searching-file-contents
function fzf-rg-search-widget -d 'find text in files'
  set rg_default_command "rg -i -l -uu"
  FZF_DEFAULT_COMMAND="rg --files" fzf \
    -m \
    -e \
    --ansi \
    --disabled \
    --reverse \
    --bind "change:reload:$rg_default_command {q} || true" \
    --preview "rg -i --pretty --context 2 {q} {}" | cut -d":" -f1,2 \
    | fzf_add_to_commandline
end
bind \cf fzf-rg-search-widget
bind -M insert \cf fzf-rg-search-widget

# Deciphered from fzf-file-widget. Somewhat unclear why it doesn't exist already!
function fzf_add_to_commandline -d 'add stdin to the command line, for fzf functions'
  read -l result
  commandline -t ""
  commandline -it -- (string escape $result)
  commandline -f repaint
end

# The following few `__git` functions are Heavily adapted from
# https://gist.github.com/aluxian/9c6f97557b7971c32fdff2f2b1da8209
function __git_fzf_is_in_git_repo -d "Check whether we're in a git repo"
  command -s -q git
    and git rev-parse HEAD >/dev/null 2>&1
end

function __git_fzf_git_status -d "fzf on files from git status"
  __git_fzf_is_in_git_repo; or return
  git -c color.status=always status --short | \
    fzf -m --ansi --preview 'git diff HEAD -- {-1} | delta' | \
    cut -c4- | \
    sed 's/.* -> //' | \
    fzf_add_to_commandline
  commandline -f repaint
end

function __git_fzf_git_branch -d "fzf on git branches"
  __git_fzf_is_in_git_repo; or return
  git branch -a --color=always | \
    grep -v '/HEAD\s' | \
    fzf -m --ansi --preview-window right:70% --preview \
    'git lg --color=always (echo {} | sed s/^..// | cut -d" " -f1) -- | head -'$LINES | \
    sed 's/^..//' | cut -d' ' -f1 | \
    sed 's#^remotes/##' | \
    fzf_add_to_commandline
end

function __git_fzf_git_tag -d "fzf on git tags"
  __git_fzf_is_in_git_repo; or return
  git tag --sort -version:refname | \
    fzf -m --ansi --preview-window right:70% --preview 'git show {} | delta' | \
    fzf_add_to_commandline
end

function __git_fzf_git_log -d "fzf on git history"
  __git_fzf_is_in_git_repo; or return
  git lg --color=always | \
  # We seem to need `--no-pager` and delta, since git will write without using
  # delta if it's not a tty.
    fzf -m --ansi --reverse --preview 'git --no-pager show (echo {} | rg "(\w+).*" -or \'$1\') | delta' | \
    rg "(\w+).*" -or '$1' | \
    fzf_add_to_commandline
end

function git_fzf_key_bindings -d "Set custom key bindings for git+fzf"
  # `-M insert` is added, as we want these in insert mode
  #
  bind -M insert \cg\cf __git_fzf_git_status
  bind -M insert \cg\cb __git_fzf_git_branch
  bind -M insert \cg\ct __git_fzf_git_tag
  bind -M insert \cg\ch __git_fzf_git_log
end

fzf_key_bindings
