{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = builtins.getEnv "USER";
  home.homeDirectory = builtins.getEnv "HOME";
  
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Fish shell configuration
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      # Add any fish shell configuration here
      # This will complement the existing fish config
    '';
    plugins = [
      # You can add fish plugins here
    ];
  };
  
  # Starship prompt
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };
  
  # Git configuration
  programs.git = {
    enable = true;
    userName = "Your Name"; # Customize this
    userEmail = "your.email@example.com"; # Customize this
    delta = {
      enable = true;
    };
  };
  
  # Packages that should be installed to the user profile
  home.packages = with pkgs; [
    # CLI tools
    atuin
    zoxide
    fzf
    navi
    # Add other packages you want installed
  ];
  
  # This value determines the Home Manager release that your
  # configuration is compatible with. The recommended approach is
  # to not set it and let Home Manager figure out the appropriate version.
  home.stateVersion = "23.11";
}