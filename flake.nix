{
  description = "Macnolo0x7D4's Nix configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
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
    nixosConfigurations."vm" = mkSystem "vm-aarch64" {
      system = "aarch64-linux";
      user = "macnolo";
    };

    nixosConfigurations."ideapad" = mkSystem "ideapad" {
      system = "x86_64-linux";
      user = "macnolo";
    };
    
    darwinConfigurations."Macnolo-Air" = mkSystem "macbook-air-m1" {
      system = "aarch64-darwin";
      user = "macnolo";
      darwin = true;
    };
  };
}
