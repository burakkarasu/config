# Local environment configuration files
This configuration is based on what I use on macOS but probably can be adapted to fit most common distros.

## Font: [JetBrains Mono](https://www.jetbrains.com/lp/mono/)
* Install nerd font version: `brew install --cask font-jetbrains-mono-nerd-font`

## Terminal Emulator: [Ghostty](https://ghostty.org/)
* `brew install --cask ghostty`

## Editor: [Helix](https://helix-editor.com/)
* `brew install helix`
* Python LSPs:
  * `brew install ruff` for linting
  * `brew install basedpyright` for type-checking
* Go LSP: `go install golang.org/x/tools/gopls@latest`
* Typescript LSP: `brew install typescript-language-server`
* JSON LSP: `brew install vscode-langservers-extracted`

