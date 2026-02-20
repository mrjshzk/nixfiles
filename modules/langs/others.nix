{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [

    glslang
    gdtoolkit_4
    godotPackages_4_6.godot

    tree-sitter
    pandoc

    luajit
    luajitPackages.luarocks-nix
    lua-language-server
    stylua

    nodejs_24

    nil
    alejandra

    compose-language-service # docker compose yaml lsp
  ];
}
