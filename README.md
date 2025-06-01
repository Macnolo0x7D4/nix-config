# Macnolo0x7D4's Nix Configuration

This repository contains Nix flake-based configurations for multiple hosts and environments, including NixOS (Linux), Nix-Darwin (macOS), and Home Manager (user-level).

## Repository Structure

- `flake.nix`
  Flake definition that specifies inputs (nixpkgs, darwin, home-manager) and outputs (`nixosConfigurations`, `darwinConfigurations`).
- `flake.lock`
  Locked versions of flake inputs for reproducibility.
- `lib/mksystem.nix`
  Function to assemble a system configuration using `nixosSystem` or `darwinSystem`, integrating Home Manager.

- `hosts/`
  Host-specific system configurations:
  - `hosts/vm-aarch64.nix`
    NixOS configuration for an aarch64 virtual machine.
  - `hosts/ideapad.nix`
    NixOS configuration for an x86_64 Ideapad laptop.
  - `hosts/macbook-air-m1.nix`
    Nix-Darwin configuration for an M1 MacBook Air.
  - `hosts/hardware/*.nix`
    Hardware-specific settings imported by the host configurations.

- `modules/`
  Reusable NixOS modules:
  - `modules/nix-core.nix`
    Core Nix settings (flakes, Nix command).
  - `modules/system.nix`
    System-wide profiles (shells, basic programs).
  - `modules/host-users.nix`
    Default user creation and trusted user settings.

- `users/<username>/`
  User-level configurations for user `macnolo`:
  - `home-manager.nix`
    Home Manager settings (packages, programs, shell aliases, XDG configs).
  - `nixos.nix`
    Extra NixOS settings for the user account (password, groups, packages).
  - `darwin.nix`
    Extra Nix-Darwin settings (Homebrew casks, user home).
  - `config.nu`
    Nu shell configuration.
  - `i3`, `rofi`, `kitty`, `ghostty`
    Configuration files for i3 window manager, Rofi launcher, Kitty terminal, and Ghostty.

## Defined Hosts

The flake provides these outputs:
- **nixosConfigurations.vm** (aarch64 Linux VM)
- **nixosConfigurations.ideapad** (x86_64 Linux Ideapad)
- **darwinConfigurations.Macnolo-Air** (aarch64-darwin MacBook Air M1)

## Prerequisites

- Nix 2.4 or newer with experimental features enabled:
  ```bash
  nix configure --experimental-features 'nix-command flakes'
  ```
- On macOS: [nix-darwin](https://github.com/nix-darwin/nix-darwin) installed.
- On Linux: Home Manager integration via flake.

## Usage

### Applying a NixOS Configuration

```bash
sudo nixos-rebuild switch --flake .#vm
# or for the Ideapad:
sudo nixos-rebuild switch --flake .#ideapad
```

### Applying Home Manager (Linux Hosts)

```bash
home-manager switch --flake .#vm
# or
home-manager switch --flake .#ideapad
```

### Applying Nix-Darwin Configuration (macOS)

```bash
darwin-rebuild switch --flake .#Macnolo-Air
```

## Adding New Hosts

To add a new host:

1. Create a host configuration file under `hosts/<name>.nix` (and optionally a hardware file under `hosts/hardware/`).
2. Add a flake output entry in `flake.nix`, for example:
   ```nix
   nixosConfigurations."<name>" = mkSystem "<name>" {
     system = "x86_64-linux";
     user = "macnolo";
   };
   ```

## License

This repository’s contents are provided as-is without warranty. Feel free to adapt and reuse.
