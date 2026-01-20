{pkgs, ...} : {
environment.systemPackages = with pkgs; [

    vscode-langservers-extracted
        typescript-language-server
        prettierd
        ];
              }
