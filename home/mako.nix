{
  config,
  pkgs,
  ...
}:
{
  services.mako = with config.colorScheme.palette; {
    enable = true;
    settings = {
      "actionable=true" = {
        anchor = "top-left";
      };
      actions = true;
      anchor = "top-right";
      background-color = "#${base01}";
      border-color = "#${base06}";
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
