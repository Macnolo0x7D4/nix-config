{ inputs, pkgs, ... }:

{
  users.users.macnolo = {
    home = "/Users/macnolo";
  };

  system.primaryUser = "macnolo";

  homebrew = {
    enable = true;

    brews = [
      "asdf"
    ];

    casks = [
      "orbstack"
      "brave-browser"
      "ghostty"
      "obsidian"
      "google-chrome"
      "discord"
      "slack"
      "spotify"
      "nordpass"
      "alfred"
    ];
  };

  security.pam.services.sudo_local.touchIdAuth = true;

  system.defaults.NSGlobalDomain.InitialKeyRepeat = 25;
  system.defaults.NSGlobalDomain.KeyRepeat = 2;
}
