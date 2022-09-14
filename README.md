## Dotfiles

### Install [iTerm2](http://iterm2.com/)
- [iTerm Color Scheme](https://github.com/mbadolato/iTerm2-Color-Schemes)
- [Atom One Dark theme for Terminal](https://github.com/nathanbuchar/atom-one-dark-terminal)
- `Preferences` -> `Profiles` -> `Terminal` -> `Terminal Emulation` -> Report Terminal Type and chosing `xterm-256color`
- `Preferences` -> `Profiles` -> `Text` -> `Non-ASCII Font` -> `Change Font` -> Select Instelled nerd-fonts
- `Preferences` -> `Profiles` -> `Keys` -> `Key Mappings` -> `Presets` -> Select `Natural Text Editing`


### Install [Wrap](https://www.warp.dev)


### Install [Homebrew](http://brew.sh/)

```bash
brew install\
  fish\ 
  sk\
  rg\
  fzf\
  asdf\
  navi\
  zoxide\
  lsd\
  starship\
  fd\
  jq\
  yq\
  bat\
  gitui\
  mosh\
  trash\
  zellij\
  proc\
  sd\
  dust\
  grex\
  git-delta\
  bandwhich\
  nushell\
  chezmoi

brew tap neovim/neovim
brew install neovim

brew tap cjbassi/ytop
brew install ytop

brew tap homebrew/cask-fonts 
brew install font-meslolg-nerd-font
```

### Config [fish shell](https://fishshell.com)
- [change default shell to fish](https://fishshell.com/docs/3.0/tutorial.html#tut_switching_to_fish)

```bash
echo /usr/local/bin/fish | sudo tee -a /etc/shells
chsh -s /usr/local/bin/fish
```


### Install [Fisher](https://github.com/jorgebucaran/fisher)

```bash
fisher install danhper/fish-ssh-agent
```


### Install Dotfiles with [chezmoi](https://www.chezmoi.io)

```bash
chezmoi init --apply dfdgsdfg
```


### Config [asdf](https://asdf-vm.com)

```bash
asdf plugin add python
asdf install python miniconda3-latest
asdf global python miniconda3-latest
```


### Config [Neovim](https://neovim.io)
- [Packer](https://github.com/wbthomason/packer.nvim)

```bash
npm i -g neovim
pip install pynvim
gem install neovim
```


### Install Apps
- Bitwarden
- GitUp
- Visual Studio Code
