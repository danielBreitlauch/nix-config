{ pkgs, ... }:

{
  home = {
    username = "am_lazytude";
    homeDirectory = "/Users/am_lazytude";
    stateVersion = "23.11";

    sessionVariables = {
      EDITOR = "nano";
      KUBE_EDITOR = "code --wait";
      DOCKER_DEFAULT_PLATFORM = "linux/amd64";
    };

    shell.enableZshIntegration = true;
  };

  imports = [
    ./programs/git.nix
    ./programs/starship.nix
    ./programs/zsh.nix
    ./programs/eza.nix
    # awscli, gh, 
  ];

  programs = {
    home-manager.enable = true;

    fzf = {
      enable = true;
      defaultCommand = "fd --type file";
    };

    zoxide.enable = true;
    direnv = {
      nix-direnv.enable = true;
      enable = true;
      silent = true;
    };
    tealdeer = {
      enable = true;
      settings.updates.auto_update = true;
    };
  };
}
