# User packages and software
{ pkgs, ... }:

{
  # Fonts
  fonts = {
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
    ];
  };
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
      # zen-browser # Add after installation

      # Terminal
      ghostty

      # IDEs and development
      jetbrains.idea-community
      windsurf
      vscode

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
      nautilus

      # CLI tools for desktop environment
      fastfetch
      playerctl
      grim
      slurp
      blueman
      zsh-powerlevel10k
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    hyprland
    # System utilities
    neovim
    wget
    curl
    zoxide
    fzf
    xdg-utils
    ripgrep

    # Wayland utilities
    wayland-utils
    wl-clipboard

    # File systems
    ntfs3g
  ];
}
