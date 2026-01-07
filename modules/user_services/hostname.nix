{
  lib,
  ...
}:

{
  options.host.hostname = lib.mkOption {
    type = lib.types.str;
    description = "Hostname for bash aliases (eg: laptop/desktop)";
  };


}
