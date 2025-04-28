{ ... }:

{
  programs.zsh = {
    enable = true;
    initContent = ''
      zstyle ':completion:*' menu select
    '';
    syntaxHighlighting = { enable = true; };
    historySubstringSearch = { enable = true; };
    enableCompletion = true;
    autosuggestion = { enable = true; };

    shellAliases = {
      kubectl = "kubecolor";
    };


    prezto = { 
      enable = true;
      editor.dotExpansion = true;
      color = true;

      ssh.identities = [
        "id_rsa"
        "id_rsa2"
        "id_github"
      ];

      syntaxHighlighting.highlighters = [
         "main"
        "brackets"
        "pattern"
        "line"
        "cursor"
        "root"
      ];

      syntaxHighlighting.styles = {
        builtin = "bg=grey";
        command = "bg=grey";
        function = "bg=grey";
      };

      syntaxHighlighting.pattern = {
        "rm*-rf*" = "fg=white,bold,bg=red";
      };

      pmodules = [
        "environment"
        "terminal"
        "editor"
        "git"
        "history"
        "homebrew"
        "osx"
        "directory"
        "rsync"
        "spectrum"
        "utility"
        "completion"
        "syntax-highlighting"
        "history-substring-search"
      ];
    };
  };
}
