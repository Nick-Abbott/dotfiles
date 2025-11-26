# Home Manager configuration
{ config, pkgs, ... }:

{
  home.stateVersion = "25.05";

  # GTK/Qt system-wide theming
  gtk.theme.name = "Gruvbox-Dark";
  gtk.theme.package = pkgs.gruvbox-gtk-theme;
  gtk.iconTheme.name = "GruvboxPlusDark";
  gtk.iconTheme.package = pkgs.gruvbox-plus-icon-theme;
  gtk.cursorTheme.name = "capitaine-cursors";
  gtk.cursorTheme.package = pkgs.capitaine-cursors;

  # Cursor theme for Wayland
  home.pointerCursor.name = "capitaine-cursors";
  home.pointerCursor.package = pkgs.capitaine-cursors;
  home.pointerCursor.size = 24;

  # Import existing dotfiles
  home.file = {
    ".zshrc".source = config.lib.file.mkOutOfStoreSymlink "/data/dev/dotfiles/.zshrc";
    ".p10k.zsh".source = config.lib.file.mkOutOfStoreSymlink "/data/dev/dotfiles/.p10k.zsh";
    ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "/data/dev/dotfiles/nvim";
    ".config/hypr".source = config.lib.file.mkOutOfStoreSymlink "/data/dev/dotfiles/hypr";
    ".config/waybar".source = config.lib.file.mkOutOfStoreSymlink "/data/dev/dotfiles/waybar";
    ".config/rofi".source = config.lib.file.mkOutOfStoreSymlink "/data/dev/dotfiles/rofi";
    ".local/share/rofi/themes".source = config.lib.file.mkOutOfStoreSymlink "/data/dev/dotfiles/rofi/themes";
    ".config/Code/User/settings.json".source = config.lib.file.mkOutOfStoreSymlink "/data/dev/dotfiles/ide-configs/Code/settings.json";
    ".config/Windsurf/User/settings.json".source = config.lib.file.mkOutOfStoreSymlink "/data/dev/dotfiles/ide-configs/Windsurf/settings.json";
  };

  # VS Code with declarative extensions
  programs.vscode = {
    enable = true;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      jdinhlife.gruvbox
    ];
  };

  # Git configuration (can be overridden by dotfiles)
  programs.git = {
    enable = true;
    extraConfig = {
      user = {
        name = "Nick-Abbott";
        email = "nick.abbott67@gmail.com";
      };
      init.defaultBranch = "main";
    };
  };

  # Zsh with your existing config and powerlevel10k
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    plugins = [
      {
        name = "powerlevel10k";
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        src = pkgs.zsh-powerlevel10k;
      }
    ];
    # Your .zshrc from dotfiles will handle initialization
  };
}
