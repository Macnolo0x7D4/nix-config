{ pkgs, inputs, ... }:

{
  environment.localBinInPath = true;

  users.users.macnolo = {
    isNormalUser = true;
    extraGroups = [ "docker", "wheel" ];
    packages = with pkgs; [
      tree
      git
    ];
  };

  programs.zsh.enable = true;
  programs.fish.enable = true;
}
