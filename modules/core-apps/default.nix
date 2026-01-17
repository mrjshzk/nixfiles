{ config, lib, pkgs, ... }:

with lib;

let
  mkApp = pkgName: cmdName: {
    package = mkOption {
      type = types.package;
      default = pkgName;
    };
    command = mkOption {
      type = types.str;
      default = cmdName;
    };
    enable = mkOption {
      type = types.bool;
      default = true;
    };
  };
in {

  options.core = with pkgs; {
    terminal = mkApp ghostty "ghostty";
    browser = mkApp librewolf "librewolf";
    fileManager = mkApp yazi "yazi";
    launcher = mkApp wofi "wofi --show drun";
    editor = mkApp neovim "nvim";
    wallpaper = mkApp wpaperd "wpaperd";
    widgets = mkApp quickshell "quickshell";
    prompt = mkApp starship "starship";

    packages = mkOption {
      type = types.listOf types.package;
      default = with config.core; [
        terminal.package
        browser.package
        fileManager.package
        launcher.package
        editor.package
        wallpaper.package
        widgets.package
        prompt.package
      ];
      description = "List of all core application packages";
    };
  };
}
