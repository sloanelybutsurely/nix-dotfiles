{
  description = "sloanelybutsurely's dotfiles via nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-old-fish.url = "github:NixOS/nixpkgs/c407032be28ca2236f45c49cfb2b8b3885294f7f";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows ="nixpkgs";
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nixpkgs-old-fish, home-manager, nixvim }:
  {
    darwinConfigurations."tid27880sperrau" = nix-darwin.lib.darwinSystem {
      modules = [
        {
          system.configurationRevision = self.rev or self.dirtyRev or null;
          programs.fish.package = nixpkgs-old-fish.legacyPackages.aarch64-darwin.fish;
        }
        ./nix-darwin
        ./nix-darwin/hosts/tid27880sperrau
        home-manager.darwinModules.home-manager
        {
          users.users.sperrault.home = "/Users/sperrault";
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "before-home-manager";
            extraSpecialArgs = {
              inherit nixvim;
              inherit nixpkgs-old-fish;
            };
            users.sperrault = import ./home-manager/users/sperrault.nix;
          };
        }
      ];
    };

    darwinConfigurations."Sloanes-MacBook-Air" = nix-darwin.lib.darwinSystem {
      modules = [
        {
          system.configurationRevision = self.rev or self.dirtyRev or null;
        }
        ./nix-darwin
        ./nix-darwin/hosts/Sloanes-MacBook-Air
        home-manager.darwinModules.home-manager
        {
          users.users.sloane.home = "/Users/sloane";
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "before-home-manager";
            extraSpecialArgs = {
              inherit nixvim;
            };
            users.sloane = import ./home-manager/users/sloane.nix;
          };
        }
      ];
    };
  };
}
