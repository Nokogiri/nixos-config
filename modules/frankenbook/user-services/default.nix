{ config, pkgs, lib, ... }:

{
  systemd.user.services = {
    rclone-nokogiri = {
      enable = true;
      description = "rclone: Remote FUSE filesystem for cloud storage config nokogiri";
      documentation = ["man:rclone(1)"];
      after = ["network-online.target"];
      wants = ["network-online.target"];
      wantedBy = ["default.target"];
      serviceConfig = {
        Type = "notify";
        ExecStart = ''${pkgs.rclone}/bin/rclone mount \
          --config=/var/lib/conf/rclone.conf \
          --vfs-cache-mode writes \
          --vfs-cache-max-size 100M \
          --log-level INFO \
          --log-file /tmp/rclone-%i.log \
          --umask 022 \
          --allow-other \
          nokogiri: /media/cloud/nokogiri
          '';
          ExecStop = "/run/wrappers/bin/fusermount -u /media/cloud/nokogiri";
          Environment = [ "PATH=/run/wrappers/bin/:$PATH" ];
      };
    };

    rclone-lyria = {
      enable = true;
      description = "rclone: Remote FUSE filesystem for cloud storage config lyria";
      documentation = ["man:rclone(1)"];
      after = ["network-online.target"];
      wants = ["network-online.target"];
      wantedBy = ["default.target"];
      serviceConfig = {
        Type = "notify";
        ExecStart = ''${pkgs.rclone}/bin/rclone mount \
          --config=/var/lib/conf/rclone.conf \
          --vfs-cache-mode writes \
          --vfs-cache-max-size 100M \
          --log-level INFO \
          --log-file /tmp/rclone-%i.log \
          --umask 022 \
          --allow-other \
          lyria: /media/cloud/lyria
          '';
          ExecStop = "/run/wrappers/bin/fusermount -u /media/cloud/lyria";
          Environment = [ "PATH=/run/wrappers/bin/:$PATH" ];
      };
    };

    rclone-guntheria = {
      enable = true;
      description = "rclone: Remote FUSE filesystem for cloud storage config guntheria";
      documentation = ["man:rclone(1)"];
      after = ["network-online.target"];
      wants = ["network-online.target"];
      wantedBy = ["default.target"];
      serviceConfig = {
        Type = "notify";
        ExecStart = ''${pkgs.rclone}/bin/rclone mount \
          --config=/var/lib/conf/rclone.conf \
          --vfs-cache-mode writes \
          --vfs-cache-max-size 100M \
          --log-level INFO \
          --log-file /tmp/rclone-%i.log \
          --umask 022 \
          --allow-other \
          guntheria: /media/cloud/guntheria
          '';
          ExecStop = "/run/wrappers/bin/fusermount -u /media/cloud/guntheria";
          Environment = [ "PATH=/run/wrappers/bin/:$PATH" ];
      };
    };

    rclone-markus = {
      enable = true;
      description = "rclone: Remote FUSE filesystem for cloud storage config markus";
      documentation = ["man:rclone(1)"];
      after = ["network-online.target"];
      wants = ["network-online.target"];
      wantedBy = ["default.target"];
      serviceConfig = {
        Type = "notify";
        ExecStart = ''${pkgs.rclone}/bin/rclone mount \
          --config=/var/lib/conf/rclone.conf \
          --vfs-cache-mode writes \
          --vfs-cache-max-size 100M \
          --log-level INFO \
          --log-file /tmp/rclone-%i.log \
          --umask 022 \
          --allow-other \
          markus: /media/cloud/markus
          '';
          ExecStop = "/run/wrappers/bin/fusermount -u /media/cloud/markus";
          Environment = [ "PATH=/run/wrappers/bin/:$PATH" ];
      };
    };
  };
}
