{
  description = "Macnolo0x7D4's Nix configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nix-darwin,
    ...
  }: let
    overlays = [
      (final: _prev: let
        pkgs-unstable = import inputs.nixpkgs-unstable {
          system = final.system;
          config.allowUnfree = true;
        };
      in {
        gh = pkgs-unstable.gh;
        claude-code = pkgs-unstable.claude-code;
        nushell = pkgs-unstable.nushell;
        opencode = pkgs-unstable.opencode;
        fish = pkgs-unstable.fish;
      })
    ];

    mkSystem = import ./lib/mksystem.nix {
      inherit overlays nixpkgs inputs;
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
