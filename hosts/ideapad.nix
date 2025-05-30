{ config, pkgs, ... }: {

  imports =
    [
      ./hardware/ideapad.nix
    ];

  nix = {
    package = pkgs.nixVersions.latest;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  system.stateVersion = "25.05";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "ideapad";

  networking.networkmanager.enable = true;

  networking.nameservers = [
    "1.1.1.1"
    "1.0.0.1"
    "8.8.8.8"
    "8.8.4.4"
  ];

  time.timeZone = "America/Mexico_City";

  security.sudo.wheelNeedsPassword = false;
  virtualisation.docker.enable = true;

  services = {
    displayManager.defaultSession = "none+i3";

    xserver = {
      enable = true;

      xkb.layout = "latam";

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
          xsel
          xclip
          brightnessctl
        ];
      };
    };
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    htop
    unzip
    man-db
    man-pages
    man-pages-posix
    groff
    less
  ];  
  
  programs.fish.enable = true;
}
