{ pkgs, ... }:
{
  imports = [ ./work_all.nix ];

  environment.systemPackages = with pkgs; [
    autoconf
    automake
    awscli2
    boost
    cmake
    coreutils
    cppcheck
    fluidsynth
    fzf
    icu76
    iperf
    lame
    link-grammar
    lld
    llvm
    ninja
    openblas
    protobuf
    #scummvm
    swig
    tectonic
    vcpkg
    vcpkg-tool
    vorbis-tools
    yamllint
  ];

  homebrew.casks = [
    "audacity"
    "balenaetcher"
    "clone-hero"
    "crossover"
    "filebot"
    "gog-galaxy"
    "heroic"
    "imazing"
    "nvidia-geforce-now"
    "openemu"
    "plex"
    "plexamp"
    "spotify"
    "steam"
    "tiptoi-manager"
  ];

  system.defaults.dock.persistent-apps = [
    "/System/Applications/App Store.app"
    "/System/Applications/Calendar.app"
    "/System/Applications/Reminders.app"
    "/System/Applications/Notes.app"
    "/System/Applications/Messages.app"
    "/System/Applications/FaceTime.app"
    "/System/Applications/Mail.app"
    "/Applications/Safari.app"
    "/System/Applications/Maps.app"
    "/Applications/Steam.app"
    "/users/am_lazytude/Applications/CrossOver/HogwartsLegacy (Hogwarts Legacy).app"
    "/Applications/CrossOver.app"
    "/Applications/GeForceNOW.app"
    "/Applications/OpenEmu.app"
    "/Applications/GOG Galaxy.app"
    "/System/Applications/Photos.app"
    "/Applications/Visual Studio Code.app"
    "/Applications/Xcode.app"
    "/Applications/Xcode.app/Contents/Applications/Instruments.app"
    "/Applications/iTerm.app"
    "/System/Applications/System Settings.app"
    "/System/Applications/Utilities/Activity Monitor.app"
  ];
}
