# hosts/laptop/intel-gpu.nix
{
  config,
  pkgs,
  ...
}: {
  # Enable Intel graphics
  services.xserver.videoDrivers = ["modesetting"];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;

    extraPackages = with pkgs; [
      intel-media-driver # For newer GPUs (Broadwell+)
      intel-vaapi-driver
      libva-vdpau-driver
      libvdpau-va-gl
    ];
  };

  # Better power management for laptop
  services.tlp.enable = true;
}
