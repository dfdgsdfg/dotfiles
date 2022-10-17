## Dotfiles

### `MacOS` Install [iTerm2](http://iterm2.com/)
- [iTerm Color Scheme](https://github.com/mbadolato/iTerm2-Color-Schemes)
- [Atom One Dark theme for Terminal](https://github.com/nathanbuchar/atom-one-dark-terminal)
- `Preferences` -> `Profiles` -> `Terminal` -> `Terminal Emulation` -> Report Terminal Type and chosing `xterm-256color`
- `Preferences` -> `Profiles` -> `Text` -> `Non-ASCII Font` -> `Change Font` -> Select Instelled nerd-fonts
- `Preferences` -> `Profiles` -> `Keys` -> `Key Mappings` -> `Presets` -> Select `Natural Text Editing`


### `MacOS` Install [Wrap](https://www.warp.dev)

### `Windows` Config [winget](https://learn.microsoft.com/en-us/windows/package-manager/winget/)

```powershell
winget install `
Microsoft.WindowsTerminal `
Microsoft.Powershell
```

### `Windows` Install [Scoop](https://scoop-docs.vercel.app)

```powershell
iex (new-object net.webclient).downloadstring('https://get.scoop.sh')

scoop install `
age `
bitwarden-cli `
chezmoi `
cloudflared `
git `
sudo `
neovim
```


### `MacOS` Install [Homebrew](http://brew.sh/)

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
 procs\
 sd\
 dust\
 grex\
 git-delta\
 bandwhich\
 nushell\
 atuin\
 cloudflared\
 bitwarden-cli\
 age\
 sops\
 wget\
 chezmoi

brew tap neovim/neovim
brew install neovim

brew tap cjbassi/ytop
brew install ytop

brew tap homebrew/cask-fonts 
brew install font-meslo-lg-nerd-font

brew install\
 kubectl\
 helm
```

### `*nix` Config [fish shell](https://fishshell.com)
- [change default shell to fish](https://fishshell.com/docs/3.0/tutorial.html#tut_switching_to_fish)

```bash
## x86
echo /usr/local/bin/fish | sudo tee -a /etc/shells
chsh -s /usr/local/bin/fish

## amd
echo /opt/homebrew/bin/fish | sudo tee -a /etc/shells
chsh -s /opt/homebrew/bin/fish
```


### `*nix` Install [Fisher](https://github.com/jorgebucaran/fisher)

```bash
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
```


### Install Dotfiles with [chezmoi](https://www.chezmoi.io)

```bash
chezmoi init --ssh --apply dfdgsdfg

# ssh config 
chezmoi init --prompt --apply
chezmoi data
```


### `*nix` Config [asdf](https://asdf-vm.com)

```bash
asdf plugin add python
asdf install python miniconda3-latest
asdf global python miniconda3-latest
```


### Config [Neovim](https://neovim.io)
- [Packer](https://github.com/wbthomason/packer.nvim)

```bash
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

npm i -g neovim
pip install pynvim
gem install neovim
```


### Install Apps
- [Bitwarden](https://bitwarden.com/download/)
- [GitUp](https://gitup.co)
- [Visual Studio Code](https://code.visualstudio.com)
- [GCP SDK](https://cloud.google.com/sdk/docs/install-sdk)


### Config SSH Daemon
- Turn off password auth

```bash
sudo tee /etc/ssh/sshd_config.d/turnoff-password.conf << EOF
PermitRootLogin no
PasswordAuthentication no
PermitEmptyPasswords no
ChallengeResponseAuthentication no
EOF
```

```powershell
# https://learn.microsoft.com/en-us/windows-server/administration/openssh/openssh_server_configuration
sudo Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0

sudo Set-Service -Name sshd -StartupType 'Automatic'

if (!(Get-NetFirewallRule -Name "OpenSSH-Server-In-TCP" -ErrorAction SilentlyContinue | Select-Object Name, Enabled)) {
    Write-Output "Firewall Rule 'OpenSSH-Server-In-TCP' does not exist, creating it..."
    New-NetFirewallRule -Name 'OpenSSH-Server-In-TCP' -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22
} else {
    Write-Output "Firewall rule 'OpenSSH-Server-In-TCP' has been created and exists."
}

$sshd_config = "$env:PROGRAMDATA\ssh\sshd_config"

$turnoffpassword = @"
PermitRootLogin no
PasswordAuthentication no
PermitEmptyPasswords no
"@

sudo Add-Content $sshd_config $turnoffpassword
(sudo Get-Content $sshd_config) -replace 'Match Group administrators', '#Match Group administrators' | Set-Content $sshd_config
(sudo Get-Content $sshd_config) -replace 'AuthorizedKeysFile __PROGRAMDATA__', '#AuthorizedKeysFile __PROGRAMDATA__' | Set-Content $sshd_config

sudo Restart-Service sshd
```
