{config, pkgs, lib, ... }:

{
  users.users.nokogiri = {
    isNormalUser = true;
    extraGroups = [ 
      "wheel"
      "video"
      "audio"
      "input"
      config.users.groups.keys.name
    ];
    shell = pkgs.zsh;
  };
}
