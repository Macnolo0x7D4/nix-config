{
  description = "Macnolo0x7D4's Nix configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nix-darwin,
    ...
  }: let
    mkSystem = import ./lib/mksystem.nix {
      inherit nixpkgs inputs;
    };
  in {
    darwinConfigurations."Macnolo-Air" = mkSystem "macbook-air-m1" {
      system = "aarch64-darwin";
      user = "macnolo";
      darwin = true;
    };
  };
}
