# Hardware configuration
{ pkgs, ... }:

{
  # Essential firmware for hardware support
  hardware.enableRedistributableFirmware = true;
  hardware.cpu.amd.updateMicrocode = true;
  services.fwupd.enable = true;

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
}
