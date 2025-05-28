{ config, pkgs, inputs, ... }:

{
  # Set up nix settings
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    substituters = [
      "https://cache.nixos.org/"
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Auto upgrade nix package and the daemon service
  services.nix-daemon.enable = true;

  # Used for backwards compatibility
  system.stateVersion = 4;

  # Create /etc/zshrc that loads the nix-darwin environment
  programs.zsh.enable = true;
  
  # Enable fish shell
  programs.fish.enable = true;
  
  # Install packages
  environment.systemPackages = with pkgs; [
    # Common CLI tools already in Brewfile
    git
    neovim
    wget
    bat
    fd
    ripgrep
    jq
    yq
    # Add any other packages you want installed system-wide
  ];
  
  # Set environment variables
  environment.variables = {
    EDITOR = "nvim";
  };
  
  # Install homebrew - allows coexistence with Nix
  # Comment this out if you prefer to manage Homebrew separately
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap"; # Remove unmanaged formulae
    };
    global = {
      brewfile = true;
    };
    # Define homebrew packages here if you want to manage via nix-darwin
    # Otherwise keep your Brewfile in the repo
    taps = [];
    brews = [];
    casks = [];
  };
  
  # System preferences/settings
  system.defaults = {
    dock = {
      autohide = true;
      minimize-to-application = true;
    };
    finder = {
      AppleShowAllExtensions = true;
      QuitMenuItem = true;
    };
    NSGlobalDomain = {
      AppleKeyboardUIMode = 3;
      AppleShowAllExtensions = true;
      InitialKeyRepeat = 15;
      KeyRepeat = 2;
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
    };
  };
}