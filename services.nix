# System services configuration
{ pkgs, ... }:

{
  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.hplipWithPlugin ];

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

  # Network discovery for printers/devices
  services.avahi.enable = true;
  services.avahi.nssmdns4 = true;

  # OpenSSH daemon
  services.openssh = {
    enable = true;
    # Allow password authentication for server access
    # (Git SSH keys will still work for Git operations)
    settings.PasswordAuthentication = true;
    settings.KbdInteractiveAuthentication = false;
  };
}
