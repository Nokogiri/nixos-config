{ config, pkgs, lib, ... }:

{
  environment = {
    enableAllTerminfo = true;
    noXlibs = true;
  };
}
