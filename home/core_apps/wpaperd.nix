{ osConfig, ... }:
let wpp = "~/backgrounds/wuzhen.jpg";
in {
  services.wpaperd = {
    enable = osConfig.core.wallpaper.enable;
    settings = {
      default = { mode = "center"; };
      any = { path = "${wpp}"; };
    };
  };
}
