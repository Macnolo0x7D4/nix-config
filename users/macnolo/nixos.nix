{ pkgs, inputs, ... }:

{
  environment.localBinInPath = true;

  users.users.macnolo = {
    hashedPassword = "$y$j9T$jtATO6yBl1wwAGeAS/Er31$UQV8SJHn1/SmfXAFrnqsZ6eBqqevG2A45knsmaPWsN/";
    isNormalUser = true;
    extraGroups = [ "docker" "wheel" ];
    shell = pkgs.fish;
    packages = with pkgs; [
      tree
      git
    ];
  };

  programs.zsh.enable = true;
  programs.fish.enable = true;
}
