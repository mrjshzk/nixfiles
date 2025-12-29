# hosts/laptop/intel-gpu.nix
{ config, pkgs, ... }:

{
  # Enable Intel graphics
  services.xserver.videoDrivers = [ "modesetting" ];
  
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    
    extraPackages = with pkgs; [
      intel-media-driver  # For newer GPUs (Broadwell+)
      vaapiIntel          # For older GPUs
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  # Better power management for laptop
  services.tlp. enable = true;
}
