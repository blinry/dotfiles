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
  };

  outputs = { nixpkgs, home-manager, nixGL, nur, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      homeConfigurations.blinry = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          {
            nixpkgs.overlays = [
              nixGL.overlay
              nur.overlay
            ];
          }
          ./home.nix
        ];
      };
    };
}
