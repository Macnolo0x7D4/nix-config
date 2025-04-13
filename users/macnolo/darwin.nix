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
      "neovide"
      "obsidian"
    ];
  };

  users.users.macnolo = {
    home = "/Users/macnolo";
  };
}
