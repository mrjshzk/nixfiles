{pkgs, ...}: {
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
}
