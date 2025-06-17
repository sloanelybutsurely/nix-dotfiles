{ ... }:
{
  system.defaults = {
    dock.persistent-apps = [
      "/Applications/Firefox.app"
      "/Applications/Things3.app"
      "/Applications/Fantastical.app"
      "/System/Applications/Messages.app"
      "/Applications/Slack.app/"
      "/Applications/Discord.app"
      "/System/Applications/Music.app"
      "/Applications/Obsidian.app"
      "/Applications/Ghostty.app"
    ];
  };

  homebrew = {
    casks = [
      "discord"
      "keycastr"
      "linear-linear"
      "netnewswire"
    ];
  };
}
