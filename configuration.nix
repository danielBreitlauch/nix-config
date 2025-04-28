{ pkgs, inputs, config, system, ... }:

{
  environment.systemPackages = with pkgs; [
    inputs.nox.packages.${system}.default
    nix-health
    jq
    ack
    act
    k3d
    tfk8s

    devenv
    wget
    watch
    httpie
    gh
    ncdu
    nmap
    mtr
    fd
    bat
    nixpkgs-fmt
    nil
    ssh-audit
    terraformer
    graphviz
    tig
    gitui
    wrk
    zsh-completions
    nix-zsh-completions
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.code-new-roman
  ];

  nix = {
    enable = true;
    package = pkgs.nix;
    settings = {
      experimental-features = "nix-command flakes";
      trusted-users = [ config.users.users.am_lazytude.name ];
    };
  };

  programs.zsh.enable = true;

  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
  system.stateVersion = 5;

  nixpkgs.hostPlatform = "aarch64-darwin";

  environment.shells = [ pkgs.zsh ];

  homebrew = {
    enable = true; # installing UI tools with Nix -> they go in /Applications/Nix Apps -> Spotlight can not find them; So I use brew for UI tools
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
    casks = [
      "iterm2"
      "firefox"
      "rapidapi"
      "shortcat"
      "monitorcontrol"
      "visual-studio-code"
      "the-unarchiver"
      "bettertouchtool"
      "bitwarden"
      "bruno"
      "discord"
      "virtualbox"
      "viscosity"
      "docker"
      "notion"
      "slack"
      "linear-linear"
    ];
  };

  system.defaults = {
    dock = {
      show-recents = false;
      autohide = true;
      show-process-indicators = false;
      persistent-apps = [
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
    };

    finder = {
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      ShowPathbar = true;
      FXEnableExtensionChangeWarning = false;
      _FXSortFoldersFirst = true;
      FXPreferredViewStyle = "Nlsv"; # List view
      FXDefaultSearchScope = "SCcf"; # When performing a search, search the current folder by default
    };

    controlcenter.BatteryShowPercentage = true;

    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      NSAutomaticSpellingCorrectionEnabled = false;
      NSWindowShouldDragOnGesture = true;
      "com.apple.keyboard.fnState" = true; # Use F1, F2, etc. keys as standard function keys.
      "com.apple.trackpad.scaling" = 3.0; # speed
      InitialKeyRepeat = 10;
      KeyRepeat = 1;
    };

    trackpad = {
      Clicking = true;
      Dragging = true;
      TrackpadRightClick = true;
    };

    WindowManager.EnableStandardClickToShowDesktop = false;

    CustomUserPreferences = {
      NSGlobalDomain = {
        WebKitDeveloperExtras = true;
      };

      "com.apple.desktopservices" = {
        # Avoid creating .DS_Store files on network or USB volumes
        DSDontWriteNetworkStores = true;
        DSDontWriteUSBStores = true;
      };
      "com.apple.screensaver" = {
        # Require password immediately after sleep or screen saver begins
        askForPassword = 1;
        askForPasswordDelay = 0;
      };
      "com.apple.AdLib" = {
        allowApplePersonalizedAdvertising = false;
      };
      # Prevent Photos from opening automatically when devices are plugged in
      "com.apple.ImageCapture".disableHotPlug = true;
      "com.apple.SoftwareUpdate" = {
        AutomaticCheckEnabled = true;
        # Check for software updates daily, not just once per week
        ScheduleFrequency = 1;
        # Download newly available updates in background
        AutomaticDownload = 1;
        # Install System data files & security updates
        CriticalUpdateInstall = 1;
      };
      "com.apple.TimeMachine".DoNotOfferNewDisksForBackup = true;
      # Turn on app auto-update
      "com.apple.commerce".AutoUpdate = true;
    };
  };

  system.activationScripts.postUserActivation.text = ''
    # Following line should allow us to avoid a logout/login cycle
    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  '';

  nixpkgs.config.allowUnfree = true;
  security.pam.services.sudo_local.touchIdAuth = true;

  users.users.am_lazytude = {
    name = "am_lazytude";
    home = "/Users/am_lazytude";
    description = "Daniel Breitlauch";
    shell = pkgs.zsh;
  };

}
