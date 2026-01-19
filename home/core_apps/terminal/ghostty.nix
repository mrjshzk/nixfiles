{ lib, osConfig, ... }: {
  programs.ghostty = lib.mkIf (osConfig.core.terminal.command == "ghostty") {
    enable = true;
    enableBashIntegration = true;

    settings = {
      window-inherit-font-size = false;
      font-size = 16;
      window-padding-x = 20;
      theme = "Dark+";
      background-opacity = "0.75";
      shell-integration-features = "ssh-terminfo";
    };
  };
}
