# Home Manager configuration
{ pkgs, ... }:

{
  home.stateVersion = "25.05";

  # Import existing dotfiles
  home.file = {
    ".zshrc".source = "/data/dev/dotfiles/.zshrc";
    ".p10k.zsh".source = "/data/dev/dotfiles/.p10k.zsh";
    ".config/nvim".source = "/data/dev/dotfiles/nvim";
    ".config/hypr".source = "/data/dev/dotfiles/hypr";
    ".config/waybar".source = "/data/dev/dotfiles/waybar";
    ".config/rofi".source = "/data/dev/dotfiles/rofi";
    ".local/share/rofi/themes".source = "/data/dev/dotfiles/rofi/themes";
    ".config/Code/User/settings.json".source = "/data/dev/dotfiles/ide-configs/Code/settings.json";
    ".config/Windsurf/User/settings.json".source = "/data/dev/dotfiles/ide-configs/Windsurf/settings.json";
  };

  # VS Code with declarative extensions
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      jdinhlife.gruvbox
    ];
  };

  # Git configuration (can be overridden by dotfiles)
  programs.git = {
    enable = true;
    config = {
      user.name = "Nick-Abbott";
      user.email = "nick.abbott67@gmail.com";
      init.defaultBranch = "main";
    };
  };

  # Zsh with your existing config and powerlevel10k
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    dotDir = ".config/zsh";
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
