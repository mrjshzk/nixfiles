{
  pkgs,
  config,
  ...
}: {
  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
      command_timeout = 1300;
      scan_timeout = 50;
      format = ''
        $username$directory$git_branch$git_status$git_commit$git_metrics
      '';
      character = {
        success_symbol = "[](bold green) ";
        error_symbol = "[✗](bold red) ";
      };

      username = {
        show_always = true;
      };
    };
  };
}
