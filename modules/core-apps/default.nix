{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  mkApp = pkgName: cmdName: {
    package = mkOption {
      type = types.package;
      default = pkgName;
    };
    command = mkOption {
      type = types.str;
      default = cmdName;
    };
  };
in {
  options.core = with pkgs; {
    terminal = mkApp ghostty "ghostty";
    browser = mkApp librewolf "librewolf";
    fileManager = mkApp yazi "yazi";
    launcher = mkApp rofi "rofi";
    editor =
      mkApp inputs.neovim-nightly-overlay.packages.${pkgs.system}.default
      "nvim";
    prompt = mkApp starship "starship";
    widgets = mkApp inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default "noctalia-shell";

    packages = mkOption {
      type = types.listOf types.package;
      default = with config.core; [
        terminal.package
        browser.package
        fileManager.package
        launcher.package
        editor.package
        prompt.package
        widgets.package
      ];
      description = "List of all core application packages";
    };
  };
}
