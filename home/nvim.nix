{
  config,
  pkgs,
  lazyvim,
  ...
}: {
  home.packages = with pkgs; [
    deadnix
    statix
    alejandra
    nixd
    clang
    tree-sitter
    luajitPackages.luarocks_bootstrap
    trashy
    glib
    kdePackages.kde-cli-tools
    git-spice
    tectonic
    mermaid-cli
    tree-sitter-grammars.tree-sitter-css
    lua5_4_compat
  ];

  imports = [lazyvim.homeManagerModules.default];

  programs.lazyvim = {
    enable = true;
    extras.lang = {
      nix.enable = true;
      python = {
        enable = true;
        installDependencies = true; # Install ruff
        installRuntimeDependencies = true; # Install python3
      };
      go = {
        enable = true;
        installDependencies = true; # Install gopls, gofumpt, etc.
        installRuntimeDependencies = true; # Install go compiler
      };
    };

    # Only needed for languages not covered by LazyVim
    #treesitterParsers = with vimPlugins.nvim-treesitter.grammarPlugins; [
    #  wgsl # WebGPU Shading Language
    #  templ # Go templ files
    #];

    plugins = {
      conform = ''
        return {
          "stevearc/conform.nvim",
          event = { "BufWritePre" },
          opts = {
            formatters_by_ft = {
              nix = { "alejandra" },
            },
            format_on_save = {
              lsp_fallback = true,
              timeout_ms = 2000,
            },
          },
        }
      '';
    };
  };
}
