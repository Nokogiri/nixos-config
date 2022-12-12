{pkgs, lib, config, ...}:
{
  services.avahi = {
    enable = true;
    hostName = config.networking.hostName;
    nssmdns = true;
    openFirewall = true;
    publish = {
      enable = true;
      addresses = true;
      workstation = true;
      hinfo = true;
      userServices = true;
    };
  };
}
