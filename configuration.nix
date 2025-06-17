{ pkgs, inputs, config, system, ... }:

{
  environment.systemPackages = with pkgs; [
    bat
    devenv
    fd
    gitui
    inputs.nox.packages.${system}.default
    mtr
    ncdu
    nil
    nix-health
    nix-zsh-completions
    nixpkgs-fmt
    nmap
    rar
    ripgrep
    ssh-audit
    tealdeer
    tig
    watch
    wget
    wireshark
    zsh-completions
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.code-new-roman
  ];

  nix = {
    enable = false; # determinate manages Nix
    package = pkgs.nix;
    settings = {
      experimental-features = "nix-command flakes";
      trusted-users = [ config.users.users.am_lazytude.name ];
    };
  };

  programs.zsh.enable = true;

  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
  system.stateVersion = 5;
  system.primaryUser = config.users.users.am_lazytude.name;

  nixpkgs.hostPlatform = "aarch64-darwin";

  environment.shells = [ pkgs.zsh ];

  homebrew = {
    enable = true; # installing UI tools with Nix -> they go in /Applications/Nix Apps -> Spotlight can not find them; So I use brew for UI tools
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
    casks = [
      "bettertouchtool"
      "coconutbattery"
      "docker"
      "firefox"
      "iterm2"
      "monitorcontrol"
      "shortcat"
      "the-unarchiver"
      "viscosity"
      "visual-studio-code"
    ];
  };

  system.defaults = {
    dock = {
      show-recents = false;
      autohide = true;
      show-process-indicators = false;
    };

    finder = {
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      ShowPathbar = true;
      _FXSortFoldersFirst = true;
      FXEnableExtensionChangeWarning = false;
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
      InitialKeyRepeat = 15;
      KeyRepeat = 2;
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

  system.activationScripts.postActivation.text = ''
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
