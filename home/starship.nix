{
  pkgs,
  config,
  ...
}:
{
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
      username = with config.colorScheme.palette; {
        format = "[$user]($style) ";
        show_always = true;
        style_root = "#${base08} bold bg:#${base01}";
        style_user = "#${base09} bold bg:#${base01}";
        disabled = false;
      };

      directory = with config.colorScheme.palette; {
        disabled = false;
        fish_style_pwd_dir_length = 0;
        format = "[$path]($style)[$read_only]($read_only_style) ";
        home_symbol = "~";
        read_only = " ";
        read_only_style = "red";
        repo_root_format = "[$before_root_path]($style)[$repo_root]($repo_root_style)[$path]($style)[$read_only]($read_only_style) ";
        style = "#${base0A} bold bg:${base01}";
        truncate_to_repo = true;
        truncation_length = 3;
        truncation_symbol = "…/";
        use_logical_path = true;
        use_os_path_sep = true;
      };

    };
  };
}
