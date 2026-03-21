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
      "1password"
      "1password-cli"
      "obsidian"
      "google-chrome"
      "discord"
      "slack"
      "spotify"
    ];
  };

  security.pam.services.sudo_local.touchIdAuth = true;
}
