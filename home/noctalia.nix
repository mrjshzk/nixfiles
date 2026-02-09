{
  inputs,
  osConfig,
  ...
}: {
  imports = [
    inputs.noctalia.homeModules.default
  ];

  # configure options
  programs.noctalia-shell = {
    enable = true;
    settings = {
      dock.enabled = false;
      general = {
        animationDisabled = true;
        radiusRatio = 0; # general radius
        iRadiusRatio = 0; # radius for input elements
      };
      colorSchemes = {
        predefinedScheme = "Vesper";
      };
      location.name = "Vila do Conde, Portugal";
      bar = {
        position = "top";
        barType = "simple";
        density = "comfortable";
        useSeparateOpacity = true;
        backgroundOpacity = 0;
        widgets = {
          left = [
            # {id = "Launcher";}
            {id = "Workspace";}
            {id = "Clock";}
            # {id = "SystemMonitor";}
            {id = "ActiveWindow";}
            {id = "MediaMini";}
          ];
          center = [];
          right = [
            {id = "Tray";}
            {id = "NotificationHistory";}
            {id = "Battery";}
            {id = "Volume";}
            # {id = "Brightness";}
            {id = "ControlCenter";}
          ];
        };
      };
      wallpaper = {
        directory = "/home/mrjshzk/backgrounds";
        transitionDuration = 1000;
      };
      applauncher = {
        terminalCommand = "${osConfig.core.terminal.command} -e";
      };
    };
  };

  home.file.".cache/noctalia/wallpapers.json" = {
    text = builtins.toJSON {
      defaultWallpaper = "/home/mrjshzk/backgrounds/artorias.png";
    };
  };
}
