{ pkgs, config, lib, ... }:

{
  security = {
    doas = {
      enable = true;
      wheelNeedsPassword = true;
      extraRules = [{
        groups = [ "wheel" ];
        noPass = false;
        keepEnv = true;
        persist = true;
      }];
    };
  };
}
