{ pkgs, ... }:
{
  programs.ghostty = {
    enable = true;
    # Enable for whichever shell you plan to use!
    enableBashIntegration = true;

    settings = {
      window-inherit-font-size = false;
      font-size = 16;
      window-padding-x = 20;
      theme = "Gruvbox Dark";
      background-opacity = "0.8";
      shell-integration-features = "ssh-terminfo";
    };
  };
}
