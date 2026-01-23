{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    cmake
    scons
    ninja
    gnumake
    arduino-cli
    arduino-ide
    platformio

    (pkgs.clang-tools.overrideAttrs (oldAttrs: {meta.priority = 9;}))
    (pkgs.clang.overrideAttrs (oldAttrs: {meta.priority = 10;}))
    (pkgs.libgcc.overrideAttrs (oldAttrs: {meta.priority = 20;}))

    shfmt
    shellcheck

    kdePackages.qtdeclarative
    kdePackages.qtwayland
  ];
}
