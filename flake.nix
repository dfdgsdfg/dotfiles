{
  description = "Dotfiles nix-darwin configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, darwin, home-manager, ... }: {
    darwinConfigurations = {
      # Change "yourhost" to your hostname
      # You can get your hostname by running `hostname -s` in terminal
      # Multiple hosts can be defined here for different machines
      yourhost = darwin.lib.darwinSystem {
        system = "aarch64-darwin"; # For Apple Silicon Mac, use "x86_64-darwin" for Intel
        modules = [
          ./nix/darwin-configuration.nix
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${builtins.getEnv "USER"} = import ./nix/home.nix;
          }
        ];
        specialArgs = { inherit inputs; };
      };
    };
  };
}