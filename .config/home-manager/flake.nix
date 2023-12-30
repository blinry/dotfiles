{
  description = "Home Manager configuration of blinry";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixGL = {
      url = "github:guibou/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
    nom = {
      url = "github:blinry/nom";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pacecalc = {
      url = "git+https://codeberg.org/blinry/pacecalc";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, nixGL, nur, nom, pacecalc, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      homeConfigurations.blinry = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          {
            nixpkgs = {
              overlays = [
                nixGL.overlay
                nur.overlay
              ];
              config.allowUnfree = true;
            };
          }
          ./modules/i3blocks.nix
          ./home.nix
        ];

        extraSpecialArgs = {
          nom = nom.packages.${system}.default;
          pacecalc = pacecalc.packages.${system}.default;
        };
      };
    };
}
