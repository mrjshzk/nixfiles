{ pkgs, ... }: {
  home.packages = with pkgs; [
    blender
    inkscape
    tectonic # LaTeX compiler
    mermaid-cli
  ];
}
