{ config, pkgs, lib, ... }:

{
  security.doas.extraRules = [{
    users = ["nokogiri"];
    noPass = true;
    keepEnv = true;
    persist = false;
  }];
}
