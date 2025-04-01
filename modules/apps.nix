{ pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    fish
    starship
  ];

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
}
