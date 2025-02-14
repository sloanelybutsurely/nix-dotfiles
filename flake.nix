{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows ="nixpkgs";
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, nixvim }:
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#tid27880sperrau
    darwinConfigurations."tid27880sperrau" = nix-darwin.lib.darwinSystem {
      modules = [
        {
          system.configurationRevision = self.rev or self.dirtyRev or null;
        }
        ./nix-darwin
        home-manager.darwinModules.home-manager
        {
          users.users.sperrault.home = "/Users/sperrault";
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "before-home-manager";
            extraSpecialArgs = {
              inherit nixvim;
            };
            users.sperrault = import ./home-manager;
          };
        }
      ];
    };
  };
}
