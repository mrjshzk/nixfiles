{
  pkgs,
  lazyvim,
  ...
}:
{
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
    vimPlugins.rustaceanvim
  ];

  imports = [ lazyvim.homeManagerModules.default ];

  programs.lazyvim = {
    enable = true;
    config = {
      options = ''
        vim.opt.timeoutlen = 200
      '';

      keymaps = ''
        vim.keymap.set("n", "<leader>H", function()
          Snacks.dashboard.open()
        end, { desc = "Open dashboard"})
      '';
    };
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
      rust = {
        enable = true;
        installDependencies = true;
        installRuntimeDependencies = true;
      };
    };
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
      which-key = ''
        return {
          {
            "folke/which-key.nvim",
            opts = {
              delay = 0,
            },
          },
        }
      '';
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
      colorblocks = ''
        return {
          "Bishop-Fox/colorblocks.nvim",
          lazy = false,
          config = function()
            require("colorblocks").setup({
              symbol = "󰹞 ",
              virt_text_pos = "eol",
              mode = "fg",
              section = { "S", "  ", "", "" },
              filetypes = { "lua", "css", "nix", "conf" },
            })
          end
        }
      '';
    };
  };
}
