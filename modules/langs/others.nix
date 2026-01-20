{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [

    glslang

    gdtoolkit_4

    tree-sitter
    pandoc

    luajit
    luajitPackages.luarocks-nix
    lua-language-server
    stylua

    nodejs_24

    nil
    alejandra
  ];
}
