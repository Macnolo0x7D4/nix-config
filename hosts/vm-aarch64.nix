{ config, pkgs, ... }: {

  imports =
    [
      ./hardware/vm-aarch64.nix
    ];

  system.stateVersion = "24.11";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "vm";

  time.timeZone = "America/Mexico_City";

  virtualisation.vmware.guest.enable = true;

  services = {
    displayManager.defaultSession = "none+i3";

    xserver = {
      enable = true;

      xkb.layout = "us";

      dpi = 220;

      desktopManager = {
        xterm.enable = false;
      };

      windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs; [
          dmenu
          i3status
          i3lock
          i3blocks
        ];
      };
    };
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    htop
  ]; 
  
  programs.zsh.shellInit = ''
    # Nix
    if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
      . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
    fi
    # End Nix
    '';

  programs.fish.enable = true;
  programs.fish.shellInit = ''
    # Nix
    if test -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish'
      source '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish'
    end
    # End Nix
    '';
}
