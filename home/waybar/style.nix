{ pkgs, config, ... }:
{
  programs.waybar.style = with config.colorScheme.palette; ''
    * {
      min-height :  0;
      padding :  0;
      margin :  0;
      color :  #ffffff;
      font-size :  20px;
      font-family :  "JetBrains Mono Propo";
    }

    window#waybar {
      background-color :  transparent;
    }

    /* Each module on the right gets unique base16 accent colors */
    #network {
      padding :  10px 10px 10px 10px;
      margin :  0 6px 0 6px;
      border-radius :  5px;
    }

    #battery {
      padding :  10px 10px 10px 10px;
      margin :  0 6px 0 6px;
      border-radius :  5px;
    }

    #language {
      padding :  10px 10px 10px 10px;
      margin :  0 6px 0 6px;
      border-radius :  5px;
    }

    #pulseaudio {
      padding :  10px 10px 10px 10px;
      margin :   0 6px 0 6px;
      border-radius :   5px;
    }

    #clock {
      padding :  10px 10px 10px 10px;
      margin :   0 6px 0 6px;
      border-radius :  5px;
    }

    #cpu {
      padding :  10px 10px 10px 10px;
      margin :  0 6px 0 6px;
      border-radius :  5px;
    }

    /* Cool workspaces with gradient effect and hover animation */
    #workspaces button {
      transition :  all 150ms ease-in-out;
      border-radius :  5px;
      min-width :  40px;
      margin-left :  10px;
      box-shadow :  0 2px 4px rgba(0, 0, 0, 0.3);
    }

    #workspaces button.hover {
      box-shadow :  0 4px 8px rgba(0, 0, 0, 0.5);
    }

    #workspaces button.active {
      min-width :   50px;
      box-shadow :  0 4px 12px rgba(29, 32, 33, 0.5);
      font-weight :  bold;
    }

    .modules-right {
      margin :   10px 10px 0 0;
    }

    .modules-left {
      margin :   10px 0 0 20px;
    }
  '';

}
