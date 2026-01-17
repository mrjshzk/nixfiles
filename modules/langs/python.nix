{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [

    python313
    python313Packages.pip
    python313Packages.black
    python313Packages.pyflakes
    python313Packages.isort
    pipenv
    python313Packages.pytest
  ];
}
