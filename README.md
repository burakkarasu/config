# Local environment configuration files
This configuration is based on what I use on macOS but probably can be adapted to fit most common distros.

## Font:
* [JetBrains Mono](https://www.jetbrains.com/lp/mono/)
* [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts)
* Install nerd font version: `brew install --cask font-jetbrains-mono-nerd-font`

## Terminal Emulator:
* [Ghostty](https://ghostty.org/)
* `brew install --cask ghostty`

## Shell
* [Zsh](https://www.zsh.org/)
  * Plugins:
    * [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
      * `brew install zsh-autosuggestions`
    * [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
      * `brew install zsh-syntax-highlighting`
* [Tmux](https://github.com/tmux/tmux/wiki)
  * `brew install tmux`

## CLI Tools
* [fzf](https://github.com/junegunn/fzf)
  * `brew install fzf`
* [bat](https://github.com/sharkdp/bat)
  * `brew install bat`

## Editor:
* [Helix](https://helix-editor.com/)
* `brew install helix`
* Python LSPs:
  * `brew install ruff` for linting
  * `brew install basedpyright` for type-checking
* Go LSP: `go install golang.org/x/tools/gopls@latest`
* Typescript LSP: `brew install typescript-language-server`
* JSON LSP: `brew install vscode-langservers-extracted`

## Git UI
* [Lazygit](https://github.com/jesseduffield/lazygit)
* `brew install lazygit`
