{pkgs, lib, config, ...}: {
  options.langs.python.enable = lib.mkEnableOption "Python toolchain";

  config = lib.mkIf config.langs.python.enable {
    environment.systemPackages = with pkgs; [
      python313Packages.python-lsp-server
      python313Packages.matplotlib
      python313Packages.numpy
      python313
      python313Packages.pip
      python313Packages.black
      python313Packages.pyflakes
      python313Packages.isort
      pipenv
      python313Packages.pytest
      python313Packages.huggingface-hub
    ];
  };
}
