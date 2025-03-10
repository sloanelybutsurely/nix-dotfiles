{ pkgs, ... }:
{
  environment.systemPackages = [];

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  security.pam.enableSudoTouchIdAuth = true;

  system.defaults = {
    dock = {
      autohide = true;
      autohide-delay = 0.05;
      orientation = "bottom";
    };
    finder = {
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      CreateDesktop = false;
      FXDefaultSearchScope = "SCcf"; # current folder
      FXEnableExtensionChangeWarning = false;
      NewWindowTarget = "Home";
      ShowPathbar = true;
      ShowStatusBar = true;
    };
  };

  environment.shells = [ pkgs.fish ];

  programs.fish = {
    enable = true;
    shellInit = ''
      eval "$(/opt/homebrew/bin/brew shellenv)"
    '';
  };

  homebrew = {
    enable = true;
    global = {
      autoUpdate = false;
    };
    onActivation = {
      autoUpdate = false;
      cleanup = "uninstall";
    };

    brews = [
      "libyaml"
      "mas"
      "openssl"
      "wxwidgets"
    ];

    casks = [
      "1password"
      "alfred"
      "arq"
      "dash@6"
      "fantastical"
      "firefox"
      "font-atkinson-hyperlegible-next"
      "font-maple-mono-nf"
      "ghostty"
      "karabiner-elements"
      "keepingyouawake"
      "obsidian"
      "rectangle"
      "tailscale"
      "unnaturalscrollwheels"
    ];

    masApps = {
      Things = 904280696;
      "Hand Mirror" = 1502839586;
    };
  };
}
