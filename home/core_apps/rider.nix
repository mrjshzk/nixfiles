{
  pkgs,
  lib,
  ...
}: let
  extra-path = with pkgs; [
    mono
    msbuild
  ];
  extra-lib = with pkgs; [
    /*
    add libs if needed
    */
  ];
  rider = pkgs.jetbrains.rider.overrideAttrs (attrs: {
    postInstall =
      ''
        # Wrap with extras
        mv $out/bin/rider $out/bin/.rider-toolless
        makeWrapper $out/bin/.rider-toolless $out/bin/rider \
          --argv0 rider \
          --prefix PATH : "${lib.makeBinPath extra-path}" \
          --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath extra-lib}"

        # Fix Unity plugin: symlink for expected /rider/ structure
        shopt -s extglob
        ln -s $out/rider/!(bin) $out/
        shopt -u extglob
      ''
      + (attrs.postInstall or "");
  });
in {
  home.packages = [rider];
}
