# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <home-manager/nixos>
      # Modular configuration files
      ./hardware.nix
      ./desktop.nix
      ./packages.nix
      ./services.nix
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

  # Home Manager for user configuration
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users.nabbott = { pkgs, ... }: import ./home.nix { inherit pkgs; };
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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
