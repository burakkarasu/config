# Set PATH, MANPATH, etc., for Homebrew.
eval "$(/opt/homebrew/bin/brew shellenv)"

# Same job as the line above, for tools homebrew does not manage. pipx, uv and
# poetry all install into ~/.local/bin, and none of them put it on PATH: most
# Linux distros add it from a default profile, macOS never does. helix's
# languages.toml needs basedpyright, which exists nowhere else.
export PATH="$HOME/.local/bin:$PATH"
# .zshrc runs per-shell, so nested shells used to prepend this twice. Keep the
# path arrays deduplicated.
typeset -U path PATH

# Setting PATH for Python 3.11
# The original version is saved in .zprofile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.11/bin:${PATH}"
export PATH
