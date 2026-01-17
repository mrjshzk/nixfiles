{ ... }: {
  programs.ghostty = {
    enableBashIntegration = true;

    settings = {
      window-inherit-font-size = false;
      font-size = 20;
      window-padding-x = 20;
      theme = "TokyoNight";
      background-opacity = "0.75";
      shell-integration-features = "ssh-terminfo";
    };
  };
}
