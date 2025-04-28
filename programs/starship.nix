{ ... }:

{
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      line_break.disabled = true;

      format = "$all $username$hostname$directory$character";
      right_format = "$git_branch$git_state$git_status";

      username = { format = "[$user](fg:135)@"; }; # Purple
      hostname = {
        ssh_only = false;
        ssh_symbol = "⚯";
        format = "[$ssh_symbol$hostname](fg:166) "; # Orange
      };
      character = {
        success_symbol = "[\\$](white)";
        error_symbol = "[✖](red)";
        vimcmd_symbol = "[N](white)";
      };
      directory = {
        style = "fg:118"; # limegreen
        truncation_length = 5;
        truncation_symbol = "";
        fish_style_pwd_dir_length = 1;
      };

      git_branch = { format = "[$symbol$branch(:$remote_branch)]($style) "; };
      git_status = {
        format = "([$ahead_behind$staged$conflicted$stashed$deleted$modified$renamed$untracked]() )";
        conflicted = "[= ](fg:red)";
        ahead = "[⬆ ](fg:yellow)";
        behind = "[⬇ ](fg:yellow)";
        diverged = "[⮃ ](fg:red)";
        up_to_date = "[✓ ](fg:118)";
        untracked = "[◼ ](fg:white)";
        stashed = "[✭ ](fg:cyan)";
        modified = "[✱ ](fg:blue)";
        staged = "[✚\($count\) ](fg:118)";
        renamed = "[➜ ](fg:purple)";
        deleted = "[✖ ](fg:red)";
      };

      python = { format = "[(\($symbol $virtualenv\) )](white)"; };
      nodejs = { format = "[$symbol($version )]($style)"; };
      rust = { format = "[$symbol($version )]($style)"; };
      nix_shell = { format = "$symbol"; };

      kubernetes = {
        disabled = false;
        symbol = "⎈";
        format = "[$symbol](bright-black) [$context <$namespace>]($style)";
        contexts = [
          {
            context_pattern = "arn:aws:eks:(?P<region>[^:]+):176291536184:cluster/(?P<cluster>[^/]+)";
            context_alias = "prod $region $cluster";
            style = "bold red";
          }
          {
            context_pattern = "arn:aws:eks:(?P<region>[^:]+):983594232711:cluster/(?P<cluster>[^/]+)";
            context_alias = "dev $cluster";
            style = "green";
          }
        ];
      };
    };
  };
}
