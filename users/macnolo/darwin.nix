{ inputs, pkgs, ... }:

{
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

  users.users.macnolo = {
    home = "/Users/macnolo";
  };
}
