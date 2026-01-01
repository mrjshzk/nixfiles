{
  config,
  lib,
  ...
}: {
  options.colorScheme = lib.mkOption {
    type = lib.types.attrs;

    default = {
      background = "#191726";
      text = "#B7D8FF";
      text_alt = "#B0CDD9";
      border = "#5B5A8C";
      border_alt = "#F2F0D5";
    };
  };
}
