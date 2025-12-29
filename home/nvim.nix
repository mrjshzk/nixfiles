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
      javascript = {
        enable = true;
        installDependencies = true;
        installRuntimeDependencies = true;
      };
    };

    # Only needed for languages not covered by LazyVim
    #treesitterParsers = with vimPlugins.nvim-treesitter.grammarPlugins; [
    #  wgsl # WebGPU Shading Language
    #  templ # Go templ files
    #];
    treesitterParsers = with pkgs.vimPlugins.nvim-treesitter-parsers; [
      css
      scss
      latex
      vue
      tsx
      templ
      wgsl
    ];

    plugins = {
      conform = ''
        return {
          "stevearc/conform.nvim",
          event = { "BufWritePre" },
          opts = {
            formatters_by_ft = {
              nix = { "alejandra" },
            },
         },
        }
      '';
      snacks = ''
        return {
          {
            "folke/snacks.nvim",
            opts = {
              picker = {
                hidden = true,
                sources = {
                  files = {
                    hidden = true, -- Show hidden/dotfiles
                  },
                },
              },
            },
          },
        }
      '';
    };
  };
}
