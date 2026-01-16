{ ... }: {
  services.mako = {
    enable = false;
    settings = {
      "actionable=true" = { anchor = "top-left"; };
      actions = true;
      anchor = "top-right";
      border-radius = 0;
      default-timeout = 5000;
      font = "JetBrains Mono 16";
      height = 100;
      icons = true;
      ignore-timeout = false;
      layer = "top";
      margin = 30;
      markup = true;
      width = 300;
    };
  };
}
