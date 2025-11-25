# User packages and software
{ pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with 'passwd'.
  users.users.nabbott = {
    isNormalUser = true;
    uid = 1000;
    description = "Primary User";
    extraGroups = [ "networkmanager" "wheel" "docker" "video" "input" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      # Browsers
      firefox
      google-chrome
      # zen-browser # Add via overlay after installation

      # Terminal
      ghostty

      # IDEs and development
      intellij-idea-community
      windsurf

      # Development tools
      nodejs
      git
      gcc

      # Desktop environment
      hyprpaper
      waybar
      rofi-wayland
      # Notification manager for Hyprland
      dunst
      libnotify

      # Applications
      spotify
      discord
      slack
      pavucontrol

      # CLI tools for desktop environment
      fastfetch
      playerctl
      grim
      slurp
      capitaine-cursors
      blueman
      zsh-powerlevel10k

      # Fonts
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })

      # Screen sharing support for Discord
      xwaylandvideobridge
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # System utilities
    neovim
    wget
    curl
    zoxide
    fzf
    xdg-utils

    # Wayland utilities
    wayland-utils
    wl-clipboard

    # File systems
    ntfs3g
  ];
}
