{ config, pkgs, ... }: {

  imports =
    [
      ./hardware/vm-aarch64.nix
    ];

  nix = {
    package = pkgs.nixVersions.latest;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  system.stateVersion = "25.05";

  boot.binfmt.emulatedSystems = ["x86_64-linux"];

  nixpkgs.config.allowUnsupportedSystem = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "vm";

  networking.hosts = {
    "127.0.0.1" = [ "vm.local" ];
  };

  time.timeZone = "America/Mexico_City";

  virtualisation.vmware.guest.enable = true;
  virtualisation.vmware.guest.headless = false;

  security.sudo.wheelNeedsPassword = false;
  virtualisation.docker.enable = true;

  services = {
    displayManager.defaultSession = "none+i3";

    xserver = {
      enable = true;

      xkb.layout = "latam";

      dpi = 180;

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
          xclip
        ];
      };
    };

    avahi = {
      enable = true;
      nssmdns4 = true;
      publish = {
        enable = true;
        domain = true;
        addresses = true;
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

  fileSystems."/host" = {
    fsType = "fuse./run/current-system/sw/bin/vmhgfs-fuse";
    device = ".host:/";
    options = [
      "umask=22"
      "uid=1000"
      "gid=1000"
      "allow_other"
      "auto_unmount"
      "defaults"
    ];
  };

  networking.firewall.enable = false;
  
  programs.fish.enable = true;
}
