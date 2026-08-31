# Set PATH, MANPATH, etc., for Homebrew.
eval "$(/opt/homebrew/bin/brew shellenv)"

# Add ~/.local/bin to PATH. Package managers can install tools there;
# pipx, uv and poetry all default to it. Linux distros add it to path by
# default, macOS does not.
export PATH="$HOME/.local/bin:$PATH"
# PATH entries can get prepended more than once, since .zshrc runs for every
# shell rather than only login shells. Keep the path arrays deduplicated.
typeset -U path PATH

# Setting PATH for Python 3.11
# The original version is saved in .zprofile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.11/bin:${PATH}"
export PATH
