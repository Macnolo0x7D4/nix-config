{ pkgs, ... }:

{
  stdenv.hostPlatform.system = {
    stateVersion = 5;
    activationScripts.postUserActivation.text = ''
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    '';
  };

  programs.zsh.enable = true;
  programs.fish.enable = true;
}
