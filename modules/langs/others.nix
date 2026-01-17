{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [

    glslang

    gdtoolkit_4

    tree-sitter
    pandoc

    luajit
    luajitPackages.luarocks-nix

    nodejs_24
  ];
}
