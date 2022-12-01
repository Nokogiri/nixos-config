{ config, pkgs, lib, ... }:

{
  systemd.user.services = {
    rclone-nokogiri = {
      enable = true;
      description =
        "rclone: Remote FUSE filesystem for cloud storage config nokogiri";
      documentation = [ "man:rclone(1)" ];
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];
      wantedBy = [ "default.target" ];
      serviceConfig = {
        Type = "notify";
        ExecStart = ''
          ${pkgs.rclone}/bin/rclone mount \
                    --config=%h/.config/rclone/rclone.conf \
                    --vfs-cache-mode full \
                    --vfs-cache-max-size 256M \
                    --log-level INFO \
                    --log-file /tmp/rclone-%i.log \
                    --umask 022 \
                    --allow-other \
                    --allow-non-empty \
                    --dir-cache-time 2h \
                    --poll-interval 5m \
                    nokogiri: /media/cloud/nokogiri
        '';
        ExecStop = "/run/wrappers/bin/fusermount -u /media/cloud/nokogiri";
        Environment = [ "PATH=/run/wrappers/bin/:$PATH" ];
      };
    };

    rclone-lyria = {
      enable = true;
      description =
        "rclone: Remote FUSE filesystem for cloud storage config lyria";
      documentation = [ "man:rclone(1)" ];
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];
      wantedBy = [ "default.target" ];
      serviceConfig = {
        Type = "notify";
        ExecStart = ''
          ${pkgs.rclone}/bin/rclone mount \
                    --config=%h/.config/rclone/rclone.conf \
                    --vfs-cache-mode full \
                    --vfs-cache-max-size 256M \
                    --log-level INFO \
                    --log-file /tmp/rclone-%i.log \
                    --umask 022 \
                    --allow-other \
                    --allow-non-empty \
                    --dir-cache-time 2h \
                    --poll-interval 5m \
                    lyria: /media/cloud/lyria
        '';
        ExecStop = "/run/wrappers/bin/fusermount -u /media/cloud/lyria";
        Environment = [ "PATH=/run/wrappers/bin/:$PATH" ];
      };
    };

    rclone-guntheria = {
      enable = true;
      description =
        "rclone: Remote FUSE filesystem for cloud storage config guntheria";
      documentation = [ "man:rclone(1)" ];
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];
      wantedBy = [ "default.target" ];
      serviceConfig = {
        Type = "notify";
        ExecStart = ''
          ${pkgs.rclone}/bin/rclone mount \
                    --config=%h/.config/rclone/rclone.conf \
                    --vfs-cache-mode full \
                    --vfs-cache-max-size 256M \
                    --log-level INFO \
                    --log-file /tmp/rclone-%i.log \
                    --umask 022 \
                    --allow-other \
                    --allow-non-empty \
                    --dir-cache-time 2h \
                    --poll-interval 5m \
                    guntheria: /media/cloud/guntheria
        '';
        ExecStop = "/run/wrappers/bin/fusermount -u /media/cloud/guntheria";
        Environment = [ "PATH=/run/wrappers/bin/:$PATH" ];
      };
    };

    rclone-markus = {
      enable = true;
      description =
        "rclone: Remote FUSE filesystem for cloud storage config markus";
      documentation = [ "man:rclone(1)" ];
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];
      wantedBy = [ "default.target" ];
      serviceConfig = {
        Type = "notify";
        ExecStart = ''
          ${pkgs.rclone}/bin/rclone mount \
                    --config=%h/.config/rclone/rclone.conf \
                    --vfs-cache-mode full \
                    --vfs-cache-max-size 256M \
                    --log-level INFO \
                    --log-file /tmp/rclone-%i.log \
                    --umask 022 \
                    --allow-other \
                    --allow-non-empty \
                    --dir-cache-time 2h \
                    --poll-interval 5m \
                    markus: /media/cloud/markus
        '';
        ExecStop = "/run/wrappers/bin/fusermount -u /media/cloud/markus";
        Environment = [ "PATH=/run/wrappers/bin/:$PATH" ];
      };
    };
    rclone-kenny = {
      enable = true;
      description =
        "rclone: Remote FUSE filesystem for cloud storage config kenny";
      documentation = [ "man:rclone(1)" ];
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];
      wantedBy = [ "default.target" ];
      serviceConfig = {
        Type = "notify";
        ExecStart = ''
          ${pkgs.rclone}/bin/rclone mount \
                    --config=%h/.config/rclone/rclone.conf \
                    --vfs-cache-mode full \
                    --vfs-cache-max-size 256M \
                    --log-level INFO \
                    --log-file /tmp/rclone-%i.log \
                    --umask 022 \
                    --allow-other \
                    --allow-non-empty \
                    --dir-cache-time 2h \
                    --poll-interval 5m \
                    kenny: /media/cloud/kenny
        '';
        ExecStop = "/run/wrappers/bin/fusermount -u /media/cloud/kenny";
        Environment = [ "PATH=/run/wrappers/bin/:$PATH" ];
      };
    };
    rclone-hildi = {
      enable = true;
      description =
        "rclone: Remote FUSE filesystem for cloud storage config hildi";
      documentation = [ "man:rclone(1)" ];
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];
      wantedBy = [ "default.target" ];
      serviceConfig = {
        Type = "notify";
        ExecStart = ''
          ${pkgs.rclone}/bin/rclone mount \
                    --config=%h/.config/rclone/rclone.conf \
                    --vfs-cache-mode full \
                    --vfs-cache-max-size 256M \
                    --log-level INFO \
                    --log-file /tmp/rclone-%i.log \
                    --umask 022 \
                    --allow-other \
                    --allow-non-empty \
                    --dir-cache-time 2h \
                    --poll-interval 5m \
                    hildi: /media/cloud/hildi
        '';
        ExecStop = "/run/wrappers/bin/fusermount -u /media/cloud/hildi";
        Environment = [ "PATH=/run/wrappers/bin/:$PATH" ];
      };
    };
  };
}
