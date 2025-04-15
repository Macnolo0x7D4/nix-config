{ isWSL, inputs, ... }:

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

    jf = "jj git fetch";
    jn = "jj new";
    js = "jj st";
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
    pkgs.elixir
    pkgs.nodejs
  ] ++ (lib.optionals (isLinux && !isWSL) [
    pkgs.rofi
    pkgs.dmenu
    pkgs.kitty
    pkgs.neovide
    pkgs.gcc
    pkgs.gnumake
    pkgs.pkg-config
    pkgs.autoconf
    pkgs.automake
    pkgs.libtool
    pkgs.ripgrep
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
}
