{ ... }:
{
  system.defaults = {
    dock.persistent-apps = [
      "/Applications/Firefox.app"
      "/System/Applications/Mail.app"
      "/Applications/Fantastical.app"
      "/Applications/Things3.app"
      "/System/Applications/Messages.app"
      "/Applications/Discord.app"
      "/Applications/Obsidian.app"
      "/Applications/Ghostty.app"
    ];
  };

  homebrew = {
    casks = [
      "discord"
    ];
  };
}
