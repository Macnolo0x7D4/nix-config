{ inputs, ... }:

{ config, lib, pkgs, ... }:

let
  isDarwin = pkgs.stdenv.isDarwin;
  isLinux = pkgs.stdenv.isLinux;

  shellAliases = {
    ga = "git add";
    gc = "git commit";
    gco = "git checkout";
    gcp = "git cherry-pick";
    gdiff = "git diff";
    gl = "git prettylog";
    gp = "git push";
    gs = "git status";
    gt = "git tag";
  } // (if isLinux then {
    pbcopy = "xclip";
    pbpaste = "xclip -o";
  } else {});

  manpager = (pkgs.writeShellScriptBin "manpager" (if isDarwin then ''
    sh -c 'col -bx | bat -l man -p'
    '' else ''
    cat "$1" | col -bx | bat --language man --style plain
  ''));
in {
  home.stateVersion = "18.09";

  xdg.enable = true;

  home.packages = [
    pkgs.neovim
    pkgs.fastfetch
    pkgs.ripgrep
    pkgs.fd
    pkgs.nodejs
    pkgs._1password-gui
    pkgs._1password-cli
  ] ++ (lib.optionals isLinux [
    pkgs.chromium
    pkgs.postman
    pkgs.emacs
    pkgs.rofi
    pkgs.elixir
    pkgs.go
    pkgs.dmenu
    pkgs.kitty
    pkgs.neovide
    pkgs.gcc
    pkgs.gnumake
    pkgs.pkg-config
    pkgs.autoconf
    pkgs.automake
    pkgs.libtool
    pkgs.inotify-tools
    pkgs.eza
    pkgs.fzf
    pkgs.jq
    pkgs.awscli2
    pkgs.bat
    pkgs.terraform
    pkgs.python3
    pkgs.zulu
    pkgs.kubectl
    pkgs.dbeaver-bin
  ]);

  home.sessionVariables = {
    LANG = "en_US.UTF-8";
    LC_CTYPE = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
    EDITOR = "vim";
    PAGER = "less -FirSwX";
    MANPAGER = "${manpager}/bin/manpager";
  } // (if isDarwin then {
    DISPLAY = "nixpkgs-390751";
  } else {}); 

  xdg.configFile = {
    "i3/config".text = builtins.readFile ./i3;
    "rofi/config.rasi".text = builtins.readFile ./rofi;
  };

  programs.gpg.enable = !isDarwin;

  programs.starship.enable = true;

  programs.fish = {
    enable = true;
    shellAliases = shellAliases;
    interactiveShellInit = "starship init fish | source";
  };

  programs.git = {
    enable = true;
    userName = "Manuel Díaz";
    userEmail = "yosoymacnolo@gmail.com"; 
    extraConfig = {
      github.user = "Macnolo0x7D4";
      init.defaultBranch = "main";
    };
  }; 

  programs.i3status = {
    enable = isLinux;

    general = {
      colors = true;
      color_good = "#8C9440";
      color_bad = "#A54242";
      color_degraded = "#DE935F";
    };

    modules = {
      ipv6.enable = false;
      "wireless _first_".enable = false;
      "battery all".enable = false;
    };
  };

  programs.kitty = {
    enable = true;
    extraConfig = builtins.readFile ./kitty;
  };

  xresources.properties = {
    "Xft.dpi" = 180;
  };

  home.pointerCursor = lib.mkIf isLinux {
    name = "Vanilla-DMZ";
    package = pkgs.vanilla-dmz;
    size = 128;
    x11.enable = true;
  };
}
