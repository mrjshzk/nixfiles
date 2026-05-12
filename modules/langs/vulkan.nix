{ pkgs, lib, config, ... }: {
  options.langs.vulkan.enable = lib.mkEnableOption "Vulkan development tools";

  config = lib.mkIf config.langs.vulkan.enable {
    environment.systemPackages = with pkgs; [
      vulkan-loader
      vulkan-headers
      vulkan-validation-layers
      vulkan-tools
      shaderc
      glfw
      glm
      cmake
      gcc
      pkg-config
    ];
  };
}
