{ pkgs, inputs, ... }:

{
  environment.localBinInPath = true;

  users.users.macnolo = {
    hashedPassword = "$y$j9T$jtATO6yBl1wwAGeAS/Er31$UQV8SJHn1/SmfXAFrnqsZ6eBqqevG2A45knsmaPWsN/";
    isNormalUser = true;
    extraGroups = [ "docker" "wheel" ];
    packages = with pkgs; [
      tree
      git
      polkit
      polkit_gnome
    ];
  };

  documentation = {
    dev.enable = true;
    man.generateCaches = true;
    nixos.includeAllModules = true;
  };

  programs.zsh.enable = true;
  programs.ssh.enableAskPassword = false;

  programs._1password.enable = true;
  
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "macnolo" ];
  };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc.lib
  ];
}
