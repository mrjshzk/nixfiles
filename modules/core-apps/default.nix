{ config, lib, pkgs, ... }:

with lib;

{
  options.core = {
    terminal = {
      package = mkOption {
        type = types.package;
        default = pkgs.ghostty;
        description = "The terminal emulator package to use";
      };
      command = mkOption {
        type = types.str;
        default = "ghostty";
        description = "The command to launch the terminal";
      };
    };

    browser = {
      package = mkOption {
        type = types.package;
        default = pkgs.librewolf;
        description = "The web browser package to use";
      };
      command = mkOption {
        type = types.str;
        default = "librewolf";
        description = "The command to launch the browser";
      };
    };

    fileManager = {
      package = mkOption {
        type = types.package;
        default = pkgs.yazi;
        description = "The file manager package to use";
      };
      command = mkOption {
        type = types.str;
        default = "yazi";
        description = "The command to launch the file manager";
      };
    };

    launcher = {
      package = mkOption {
        type = types.package;
        default = pkgs.wofi;
        description = "The application launcher package to use";
      };
      command = mkOption {
        type = types.str;
        default = "wofi --show drun";
        description = "The command to launch the application launcher";
      };
    };

    editor = {
      package = mkOption {
        type = types.package;
        default = pkgs.neovim;
        description = "The text editor package to use";
      };
      command = mkOption {
        type = types.str;
        default = "nvim";
        description = "The command to launch the editor";
      };
    };

    packages = mkOption {
      type = types.listOf types.package;
      default = [
        config.core.terminal.package
        config.core.browser.package
        config.core.fileManager.package
        config.core.launcher.package
        config.core.editor.package
      ];
      description = "List of all core application packages";
    };
  };
}
