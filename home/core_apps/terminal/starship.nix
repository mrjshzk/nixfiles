{ lib, osConfig, ... }: {
  programs.starship = lib.mkIf (osConfig.core.prompt.command == "starship") {
    enable = true;
    settings = {
      add_newline = true;
      command_timeout = 1300;
      scan_timeout = 50;
      format = ''
        $username$directory$git_branch$git_status$git_commit
      '';
      character = {
        success_symbol = "[](bold green) ";
        error_symbol = "[✗](bold red) ";
      };
      username = {
        format = "[$user]($style) ";
        style_user = "#BBBBBB";
        style_root = "#FFCB6B"; # subtle gold for root
        show_always = true;
        disabled = false;
      };

      directory = {
        disabled = false;
        fish_style_pwd_dir_length = 0;
        format = "[$path]($style)[$read_only]($read_only_style) ";
        style = "#EBD5AB";
        home_symbol = "~";
        read_only = " ";
        read_only_style = "#628141";
        repo_root_format =
          "[$before_root_path]($style)[$repo_root]($repo_root_style)[$path]($style)[$read_only]($read_only_style) ";
        repo_root_style = "#8BAE66";
        truncate_to_repo = true;
        truncation_length = 3;
        truncation_symbol = "…/";
        use_logical_path = true;
        use_os_path_sep = true;
      };
      git_branch = { style = "#EBD5AB"; };
      git_status = { style = "#FFCB6B"; };
      git_commit = { style = "#C792EA"; };
    };
  };
}
