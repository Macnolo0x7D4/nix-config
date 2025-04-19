{ inputs, pkgs, ... }:

{
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = false;
    };

    taps = [
      "homebrew/services"
    ];

    brews = [
    ];

    casks = [
      "1password"
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
