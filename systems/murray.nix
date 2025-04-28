{ pkgs, ... }:
{
  imports = [ ./work_all.nix ];

  environment.systemPackages = with pkgs; [
    k3d
    terraform-docs
    terraformer
    tfk8s
    wrk
  ];

  homebrew.casks = [
    "bitwarden"
    "discord"
  ];

  system.defaults.dock.persistent-apps = [
    "/System/Applications/Calendar.app"
    "/System/Applications/Mail.app"
    "/System/Applications/Reminders.app"
    "/System/Applications/Notes.app"
    "/System/Applications/Messages.app"
    "/Applications/Linear.app"
    "/Applications/Notion.app"
    "/Applications/Slack.app"
    "/Applications/Safari.app"
    "/Applications/Visual Studio Code.app"
    "/Applications/iTerm.app"
    "/System/Applications/System Settings.app"
    "/System/Applications/Utilities/Activity Monitor.app"
  ];
}
