# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <home-manager/nixos>
    ];

  # Add Zen Browser overlay
  nixpkgs.overlays = [
    (final: prev: {
      zen-browser = prev.callPackage (builtins.fetchTarball {
        url = "https://github.com/zen-browser/desktop/archive/refs/heads/main.tar.gz";
        sha256 = "sha256-1l8q4n8q3z9j7x5v6w2k3m1p2r4t5y6u7i8o9p0q1r2s3t4u5v6w7x8y9z0";
      }) {};
    })
  ];

  # Use the latest kernel for better hardware support (Radeon 9070)
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Bootloader for dual boot Windows support
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
    useOSProber = true; # Detect Windows automatically
    timeout = 5; # Give time to select Windows in GRUB
  };
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.hostName = "Nick-Workstation"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and pretty well supported.

  # Set your time zone.
  time.timeZone = "America/Phoenix";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable Hyprland Wayland compositor
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Enable SDDM display manager for login
  services.xserver.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  # Enable XDG desktop portal for screen sharing
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "*";
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
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
      zen-browser

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

  # Enable Steam with proper integration
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  # Enable Docker
  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  # Essential firmware for hardware support
  hardware.enableRedistributableFirmware = true;
  hardware.cpu.amd.updateMicrocode = true;
  services.fwupd.enable = true;

  # Network discovery for printers/devices
  services.avahi.enable = true;
  services.avahi.nssmdns4 = true;
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.hplipWithPlugin ];
  
  # Bluetooth support
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Enable OpenGL (for AMD GPU)
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # Load AMD driver
  services.xserver.videoDrivers = [ "amdgpu" ];

  # Enable zsh shell
  programs.zsh.enable = true;

  # Home Manager for user configuration
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users.nabbott = { pkgs, ... }: {
      home.stateVersion = "24.11";

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
    };
  };

  # OpenSSH daemon
  services.openssh = {
    enable = true;
    # Allow password authentication for server access
    # (Git SSH keys will still work for Git operations)
    settings.PasswordAuthentication = true;
    settings.KbdInteractiveAuthentication = false;
  };

  # Auto-mount secondary drive with dotfiles (requires drive to be labeled "DATA")
  fileSystems."/data" = {
    device = "/dev/disk/by-label/DATA";
    fsType = "ext4";
    options = [ "nofail" ]; # Prevent boot failure if drive missing
  };

  # Open ports in the firewall.
  networking.firewall.enable = true; # Enable firewall for security
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
