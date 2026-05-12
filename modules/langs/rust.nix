{ pkgs, inputs, lib, config, ... }:
{
  options.langs.rust.enable = lib.mkEnableOption "Rust toolchain";

  config = lib.mkIf config.langs.rust.enable {
    nixpkgs.overlays = [ inputs.fenix.overlays.default ];

    environment.systemPackages = [
      (pkgs.fenix.complete.withComponents [
        "cargo"
        "clippy"
        "rust-src"
        "rustc"
        "rustfmt"
      ])
      pkgs.rust-analyzer-nightly
    ];
  };
}
