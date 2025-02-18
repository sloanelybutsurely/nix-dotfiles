{ nixpkgs-old-fish, ... }:
{
  imports = [ ../default.nix ];
  programs.fish.package = nixpkgs-old-fish.legacyPackages.aarch64-darwin.fish;
  home = {
    username = "sperrault";
    homeDirectory = "/Users/sperrault";
  };
}
