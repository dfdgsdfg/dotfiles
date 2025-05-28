# This is an example file showing how to create host-specific configurations
# Copy this file and rename it to your hostname.nix to customize your setup
{ config, pkgs, ... }:

{
  # Import the base configuration
  imports = [ ./darwin-configuration.nix ];

  # Override or add settings specific to this machine
  environment.systemPackages = with pkgs; [
    # Add host-specific packages here
  ];

  # Host-specific system preferences
  system.defaults = {
    # Override or extend system preferences for this host
  };

  # Host-specific homebrew configuration
  homebrew = {
    # You can override the base homebrew configuration here
    taps = [
      # Host-specific taps
    ];
    brews = [
      # Host-specific brews
    ];
    casks = [
      # Host-specific casks
    ];
  };
}