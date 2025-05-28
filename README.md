## Dotfiles

### `MacOS` Install [iTerm2](http://iterm2.com/)
- [iTerm Color Scheme](https://github.com/mbadolato/iTerm2-Color-Schemes)
- [Atom One Dark theme for Terminal](https://github.com/nathanbuchar/atom-one-dark-terminal)
- `Preferences` -> `Profiles` -> `Terminal` -> `Terminal Emulation` -> Report Terminal Type and chosing `xterm-256color`
- `Preferences` -> `Profiles` -> `Text` -> `Non-ASCII Font` -> `Change Font` -> Select Instelled nerd-fonts
- `Preferences` -> `Profiles` -> `Keys` -> `Key Mappings` -> `Presets` -> Select `Natural Text Editing`


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
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew bundle
brew bundle --file Brewfile-cask

# Needs Appstore login
brew bundle --file Brewfile-app 
```

### `*nix` Install [Nix](https://nixos.org/download.html)

```bash
# For single-user installation
sh <(curl -L https://nixos.org/nix/install) --no-daemon

# For multi-user installation
sh <(curl -L https://nixos.org/nix/install)

# macOS 10.15 Catalina or newer needs this extra step
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf
```

#### Benefits of Nix

- **Reproducible**: Same packages and versions across all machines
- **Declarative**: System configuration defined in code
- **Reliable**: No dependency conflicts, clean rollbacks
- **Multi-user**: Different users can have different configurations without interference
- **Atomic upgrades and rollbacks**: Easy to go back if something breaks
- **Works alongside Homebrew**: Can be used together with existing setup

### `MacOS` Install [nix-darwin](https://github.com/LnL7/nix-darwin)

```bash
# First ensure Nix is installed from the step above

# Clone this repo to get the darwin configuration
# or use the example configuration below to create your own
git clone https://github.com/dfdgsdfg/dotfiles.git
cd dotfiles

# Build the initial configuration (first-time setup)
nix build .#darwinConfigurations.$(hostname -s).system

# Apply the configuration
./result/sw/bin/darwin-rebuild switch --flake .#
```

### Using Nix and nix-darwin

The Nix configuration is organized as follows:

- `flake.nix`: The main entry point for nix-darwin
- `nix/darwin-configuration.nix`: Base configuration for macOS systems
- `nix/home.nix`: Home Manager configuration for user environment

To customize for your machine:

1. Edit `flake.nix` to change "yourhost" to your machine's hostname
2. Customize `nix/home.nix` with your Git information and preferred packages
3. Create a host-specific configuration file by copying `nix/example-host.nix` to `nix/yourhostname.nix`
4. Update the configuration: `darwin-rebuild switch --flake .#`

After setting up, you can update your system with:

```bash
# Update packages and apply configuration
darwin-rebuild switch --flake .#
```

### `*nix` Config [mise](https://github.com/jdx/mise)
```sh
mise i
mise ls

# rustup
# https://mise.jdx.dev/lang/rust.html
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```


### `*nix` Config [fish shell](https://fishshell.com)
- [change default shell to fish](https://fishshell.com/docs/3.0/tutorial.html#tut_switching_to_fish)

```bash
## x86
echo /usr/local/bin/fish | sudo tee -a /etc/shells
chsh -s /usr/local/bin/fish

## arm
echo /opt/homebrew/bin/fish | sudo tee -a /etc/shells
chsh -s /opt/homebrew/bin/fish
```


### `*nix` Install [Fisher](https://github.com/jorgebucaran/fisher)

```bash
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
```


### Install Dotfiles with [chezmoi](https://www.chezmoi.io)

```bash
# need key.txt (age) on ~
chezmoi init --ssh --apply dfdgsdfg

# ssh config 
chezmoi init --prompt --apply
chezmoi data
```


### `*nix` Config [mise](https://mise.jdx.dev/)

```bash
# https://mise.jdx.dev/ide-integration.html#jetbrains-editors-intellij-rustrover-pycharm-webstorm-rubymine-goland-etc
ln -s ~/.local/share/mise ~/.asdf
```


### Config [Neovim](https://neovim.io)
- [lazy nvim](https://github.com/folke/lazy.nvim)

```bash
npm i -g neovim
pip install pynvim
gem install neovim
```


### Config Playwright
https://playwright.dev/python/docs/intro

```sh
conda config --add channels conda-forge
conda config --add channels microsoft
conda install pytest-playwright
```


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
