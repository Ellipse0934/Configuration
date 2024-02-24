{
  description = "Home Manager configuration of aditya";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    utils.url = "github:gytis-ivaskevicius/flake-utils-plus/v1.4.0";
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      overlays = import ./overlays;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      overlaysBuilder = channels:
      [
        overlays
      ];
      homeConfigurations."aditya" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
       
        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ./home.nix ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}
