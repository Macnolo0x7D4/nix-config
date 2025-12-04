{ inputs, ... }:

{ config, lib, pkgs, ... }:

let
  isDarwin = pkgs.stdenv.isDarwin;
  isLinux = pkgs.stdenv.isLinux;
in {
  home.stateVersion = "25.05";

  xdg.enable = true;

  home.packages = [
    pkgs.neovim
    pkgs.fastfetch
    pkgs.ripgrep
    pkgs.fd
    pkgs.nodejs
    pkgs.jujutsu
    pkgs.elixir
    pkgs.clojure
    pkgs.go
    pkgs.fzf
    pkgs.jq
    pkgs.kubectl
    pkgs.kubernetes-helm
    pkgs.kubeseal
    pkgs.awscli2
    pkgs.bat
    pkgs.terraform
    pkgs.zulu
    pkgs.pnpm
    pkgs.claude-code
    pkgs.codex
    pkgs.leiningen
    pkgs.watchman
    pkgs.lazygit
    pkgs.lua
    pkgs.luarocks
    pkgs.elixir-ls
    pkgs.clojure-lsp
    pkgs.jdt-language-server
    pkgs.uv
    pkgs.google-cloud-sdk
    pkgs.gh
    pkgs.bun
    pkgs.meson
    pkgs.ninja
    pkgs.cmake
    pkgs.bazel
  ] ++ (lib.optionals isLinux [
    pkgs.python3
    pkgs.chromium
    pkgs.bruno
    pkgs.rofi
    pkgs.gcc
    pkgs.gnumake
    pkgs.pkg-config
    pkgs.autoconf
    pkgs.automake
    pkgs.libtool
    pkgs.inotify-tools
    pkgs.dbeaver-bin
    pkgs.postman
  ]);

  home.sessionVariables = {
    LANG = "en_US.UTF-8";
    LC_CTYPE = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
    EDITOR = "vim";
    PAGER = "less -FirSwX";
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    MANROFFOPT = "-c";
    LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib";
  } // (if isDarwin then {
    DISPLAY = "nixpkgs-390751";
  } else {});

  xdg.configFile = {
    "i3/config".text = builtins.readFile ./i3;
    "rofi/config.rasi".text = builtins.readFile ./rofi;
    "ghostty/config".text = builtins.readFile ./ghostty;
  };

  programs.gpg.enable = !isDarwin;

  programs.starship.enable = true;

  programs.fish = {
    enable = true;
    interactiveShellInit = "starship init fish | source";
  };

  programs.nushell = {
    enable = true;
    configFile.source = ./config.nu;
  };

  programs.git = {
    enable = true;
    userName = "Manuel Díaz";
    userEmail = "diaz@macnolo.net";
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
    enable = isLinux;
    extraConfig = builtins.readFile ./kitty;
  };

  programs.ghostty = {
    enable = isLinux;
  };

  programs.emacs = {
     enable = true;
     package = pkgs.emacs-gtk;
  };

  programs.tmux = {
    enable = true;
    baseIndex = 1;

    keyMode = "vi";

    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavor 'mocha'
          set -g @catppuccin_window_status_style "rounded"
        '';
      }
    ];

    extraConfig = lib.concatStrings([
      (builtins.readFile ./tmux.conf)
      "set-option -g default-shell ${pkgs.nushell}/bin/nu"
    ]);
  };

  programs.zoxide = {
    enable = true;
    enableNushellIntegration = true;
  };

  xresources.properties = lib.mkIf isLinux {
    "Xft.dpi" = 180;
  };

  home.pointerCursor = lib.mkIf isLinux {
    name = "Vanilla-DMZ";
    package = pkgs.vanilla-dmz;
    size = 128;
    x11.enable = true;
  };
}
