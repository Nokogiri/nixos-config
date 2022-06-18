{config, pkgs, lib, ... }:

{
  users.groups = {
    nokogiri = {
      gid = 1000;
    };
  };

  users.users.nokogiri = {
    description = "It'sa Me Nokogiri...a!";
    isNormalUser = true;
    group = "nokogiri";
    extraGroups = [ 
      "audio"
      "disk"
      "input"
      "uinput"
      "users"
      "video"
      "wheel"
      config.users.groups.keys.name
    ];
    shell = pkgs.zsh;
  };
}
