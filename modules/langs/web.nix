{pkgs, lib, config, ...}: {
  options.langs.web.enable = lib.mkEnableOption "Web/TypeScript toolchain";

  config = lib.mkIf config.langs.web.enable {
    environment.systemPackages = with pkgs; [
      vscode-langservers-extracted
      typescript-language-server
      prettierd
      prettier
      live-server
    ];
  };
}
