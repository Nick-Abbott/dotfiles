# Desktop environment configuration
{ pkgs, ... }:

{
  # Enable Hyprland Wayland compositor
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Enable SDDM display manager for login
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  # Enable XDG desktop portal for screen sharing
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
    config.common.default = "hyprland";
    wlr.enable = false;
  };

  # Configure keymap in X11
  services.xserver.enable = true;

  # Enable zsh shell
  programs.zsh.enable = true;
}
