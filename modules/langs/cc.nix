{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [

    cmake
    gnumake
    arduino-cli
    platformio

    (pkgs.clang-tools.overrideAttrs (oldAttrs: { meta.priority = 9; }))
    (pkgs.clang.overrideAttrs (oldAttrs: { meta.priority = 10; }))
    (pkgs.gcc.overrideAttrs (oldAttrs: { meta.priority = 20; }))

    shfmt
    shellcheck

    kdePackages.qtdeclarative
    kdePackages.qtwayland
  ];
}
