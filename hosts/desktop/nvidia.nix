# hosts/desktop/nvidia.nix
{ config, pkgs, ... }: 


{
  # Enable NVIDIA drivers
  services.xserver.videoDrivers = [ "nvidia" ];
  
  services.power-profiles-daemon.enable = true;
  hardware.nvidia = {
    # Use open source or proprietary drivers
    open = false;  # Set to true for open-source drivers
    
    # Enable modesetting (required for Wayland/Hyprland)
    modesetting.enable = true;
    
    # Power management
    powerManagement.enable = true;
    nvidiaSettings = true; 
  };

  boot.blacklistedKernelModules = ["nouveau"];

  # Hyprland environment variables for NVIDIA
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";
    XDG_SESSION_TYPE = "wayland";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    WLR_NO_HARDWARE_CURSORS = "1";
  };
}
