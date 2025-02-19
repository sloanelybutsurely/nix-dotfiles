{ ... }: {
  system.defaults = {
    dock.persistent-apps = [
      "/Applications/Firefox.app"
      "/Applications/Things3.app"
      "/System/Applications/Mail.app"
      "/Applications/Fantastical.app"
      "/Applications/Microsoft Outlook.app"
      "/Applications/Microsoft Teams.app"
      "/Applications/Slack.app"
      "/Applications/Obsidian.app"
      "/Applications/Ghostty.app"
    ];
  };

  homebrew = {
    casks = [
      "discord"
      "postgres-unofficial"
      "postico"
      "slack"
    ];
  };
}
