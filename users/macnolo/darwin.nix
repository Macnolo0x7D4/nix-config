{ inputs, pkgs, ... }:

{
  users.users.macnolo = {
    home = "/Users/macnolo";
  };

  system.primaryUser = "macnolo";

  homebrew = {
    enable = true;

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
}
