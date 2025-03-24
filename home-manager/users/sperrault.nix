{ ... }:
{
  imports = [ ../default.nix ];
  home = {
    username = "sperrault";
    homeDirectory = "/Users/sperrault";

    sessionPath = [
      "/Applications/Postgres.app/Contents/Versions/latest/bin"
    ];
  };
}
