# ZSH Configuration
# Assumes the following plugins/tools are installed:
# * zsh-autosuggestions
# * zsh-syntax-highlighting
# * fzf
# * bat
# * helix
# * tmux
# zmodload zsh/zprof UNCOMMENT FOR PROFILING

# Specify command history file name
HISTFILE=~/.zsh_history
# Record a maximum of 3m entries in command history.
HISTSIZE=3000000
SAVEHIST=$HISTSIZE
# Record time and duration of execution along with the command itself.
setopt extendedhistory
# Record commands to history aas soon as they are entered, not when the session is closed.
setopt incappendhistorytime
# When recording a command, remove its previous duplicates.
setopt histignorealldups
# Remove superflous whitespace from a command before adding it to history
setopt histreduceblanks

# Make ls colorful by default. Other commands/apps may consider this env var
# to determine whether to display colors.
export CLICOLOR=1

# Activate completion system
autoload -Uz compinit

# Compinit call leads to zsh checking the cached file to see
# if it needs regenerating. That takes a long time. Do this only
# once a day.
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
# Use the generated file without checking.
compinit -C

# Set gruvbox theme for fzf.
export FZF_DEFAULT_OPTS=" \
--color=bg+:#3c3836,bg:#282828,spinner:#fabd2f,hl:#fb4934 \
--color=fg:#ebdbb2,header:#fb4934,info:#8ec07c,pointer:#fabd2f \
--color=marker:#83a598,fg+:#ebdbb2,prompt:#8ec07c,hl+:#fb4934 \
--color=selected-bg:#504945 \
--color=border:#665c54,label:#ebdbb2"

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# Somewhat interesting new thing. displays a file tree in a left-side popup
# had to install tree for this (brew install tree)
ft () {
  depth="${1:-3}"
  tmux display-popup -w 15% -h 100% -x 0 -d "$PWD" -E "tree --dirsfirst --filelimit 50 -L $depth -aC | less -R"
}
# Start workspace search. Enter opens in helix. Ctrl+O opens in helix with
# option to return to search. Search is done by ripgrep, fzf just provides
# the interactive cli.
workspace_search () {
  RELOAD='reload:rg --column --color=always --smart-case {q} || :'
  fzf --disabled --ansi \
      --bind "start:$RELOAD" --bind "change:$RELOAD" \
      --bind 'enter:become:hx {1} +{2}' \
      --bind 'ctrl-o:execute:hx {1} +{2}' \
      --delimiter : \
      --preview 'bat --style=full --theme=gruvbox-dark --color=always --highlight-line {2} {1}' \
      --preview-window '~4,+{2}+4/3,<80(up)'
}

# Inline suggestions based on history, right arrow key to complete. Super useful.
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# make git info available in prompt using vcs_info which is included with zsh
autoload -Uz vcs_info
# Function to print out first line of prompt
top_prompt() {
  # Load git info
  vcs_info
  # Current directory, in bold bright blue
  CURRENT_DIR="%B%12F%~%f%b"
  # Add ' on the/git/branch' if in a git repo
  BRANCH=$vcs_info_msg_0_
  TOP_LEFT_PROMPT=$CURRENT_DIR
  if [[ -n $BRANCH ]]; then
    TOP_LEFT_PROMPT="$CURRENT_DIR on %B%3F$BRANCH%f%b"
  fi
  # 
  print -P $TOP_LEFT_PROMPT

  # Leaving this here in case I ever want to have a top right prompt
  # Calculate space left in line from left prompt
  # RIGHTWIDTH=$(($COLUMNS-${#LEFT}))
  # print -P "%B%12F$LEFT%b%f%B%1F${(l:$RIGHTWIDTH:: :)TOP_RIGHT_PROMPT}%f%b"
}

# Make sure precmd func is executed
precmd_functions+=( top_prompt )
setopt prompt_subst
zstyle ':vcs_info:git:*' formats ' %b'
zstyle ':vcs_info:*' enable git
# set prompt
# Green checkmark or red cross based on whether last command
# succeeded, and then a ❯
export PROMPT='%(?.%10F✓%f.%9F×%f) %B%10F❯%f%b '

# To remind me what color codes correspond to which colors and what they look like when bright/bold
what_colors() {
  for color in {0..7}; do
    bright=$(( color + 8 ))
    print -P - "Color: %${color}F${color}%f -> Bright: %${bright}F${bright}%f -> Bold: %B%${color}F${color}%f%b -> Bold Bright: %B%${bright}F${bright}%f%b"
  done
}

export EDITOR='hx'
# I hate typing this so here's an alias
alias zc="hx ~/.zshrc"
# Tmux config
alias tmc="hx ~/.tmux.conf"
# Ghostty config
alias ghc="hx ~/.config/ghostty/config"
# Helix config
alias hc="hx ~/.config/helix/config.toml"
# Helix lang config
alias hcl="hx ~/.config/helix/languages.toml"
# In a poetry codebase, starting hx with poetry enables hx to recognize installed packages
alias phx="PYTHONPATH=$(pwd) poetry run hx ."
# git aliases
alias gpo='git push origin $(git rev-parse --abbrev-ref HEAD)'
alias gco='git checkout'
alias gadd='git add'
alias gst='git status'
alias gcm='git commit'
alias gdfs='git diff --staged'
alias gmm='git merge --no-ff origin/main'
# copy revision number, macOS-specific
function gcv() {
  revision_id=$(git rev-parse HEAD)
  echo -n "$revision_id" | pbcopy
  echo "Copied \e[1m$revision_id\e[0m"
}
function gdf() {
  git diff $@
}

# Lazygit's default config directory is stupid on macOS if I don't set this.
export XDG_CONFIG_HOME="$HOME/.config"
alias lg="lazygit"


# Syntax highlighting for commands as they are typed. HAS TO BE AT THE BOTTOM
# because it uses zsh line editor (ZLE)
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# zprof UNCOMMENT FOR PROFILING

