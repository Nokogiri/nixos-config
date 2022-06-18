{ config, pkgs, lib, ... }:

{
  nixpkgs.overlays = [
    (self: super:
  {
    fusuma = super.callPackage ../pkgs/fusuma { };
  })
];
    environment.systemPackages = with pkgs; [
      fusuma
    ];

    systemd.user.services.fusuma = {
      partOf = ["graphical-session.target"];
      after = ["graphicial-session.target"];
      path = [ pkgs.libinput ];
      wantedBy = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = ":${pkgs.fusuma}/bin/fusuma";
        TimeoutSec = 5;
        Restart = "on-failure";
        Slice = "app.slice";
      };
    };
  }
