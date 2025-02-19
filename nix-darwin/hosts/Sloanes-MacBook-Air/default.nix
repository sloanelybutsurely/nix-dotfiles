{ ... }:
{
  system.defaults = {
    dock.persistent-apps = [
      "/Applications/Firefox.app"
      "/Applications/Things3.app"
      "/System/Applications/Mail.app"
      "/Applications/Fantastical.app"
      "/System/Applications/Messages.app"
      "/Applications/Discord.app"
      "/System/Applications/Music.app"
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
