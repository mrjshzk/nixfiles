{
  pkgs,
  nix-colors,
  ...
}: {
  programs.ghostty = {
    enable = true;
    # Enable for whichever shell you plan to use!
    enableBashIntegration = true;

    settings = {
      theme = "Abernathy";
      background-opacity = "0.75";
    };
  };
}
