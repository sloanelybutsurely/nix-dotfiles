{ ... }:
{
  imports = [ ../default.nix ];
  home = {
    username = "sperrault";
    homeDirectory = "/Users/sperrault";

    sessionPath = [
      "/Applications/Postgres.app/Contents/Versions/15/bin"
    ];
  };
}
