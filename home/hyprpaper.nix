{
  pkgs,
  config,
  ...
}: {
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = ["~/backgrounds/courbet.jpg" "~/backgrounds/skeleton_army.jpg" "~/backgrounds/wuzhen.jpg"];
      wallpaper = ["eDP-1,~/backgrounds/skeleton_army.jpg" "HDMI-A-1,~/backgrounds/skeleton_army.jpg" "DP-3,~/backgrounds/skeleton_army.jpg"];
    };
  };
}
