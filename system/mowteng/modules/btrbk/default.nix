{ config, pkgs, lib, ... }: {
  services.btrbk = {
    extraPackages = with pkgs; [ mbuffer zstd ];
    instances = {
      "btrbk" = {
        settings = {
          stream_buffer = "512m";
          snapshot_create = "ondemand";
          incremental = "yes";
          snapshot_preserve_min = "1d";
          snapshot_preserve = "1d";
          target_preserve_min = "no";
          target_preserve = "20d 10w *m";

          volume = {
            "/data/butter" = {
              snapshot_dir = "@snapshots";
              subvolume = {
                "@nixroot" = { };
                "@nix" = { };
                "@home" = { target_preserve = "7d 4w"; };
              };
              target = "/media/btrbk/snapshots/";
            };
          };
        };
      };
      "homeassistant" = {
        settings = {
          ssh_identity = "/home/nokogiri/.ssh/id_ed25519";
          ssh_user = "nokogiri";
          backend_remote = "btrfs-progs-sudo";
          stream_buffer = "512m";
          stream_compress = "zstd";
          stream_compress_level = "9";
          stream_compress_threads = "4";
          snapshot_create = "ondemand";
          incremental = "yes";
          snapshot_preserve_min = "3d";
          snapshot_preserve = "14d";
          target_preserve_min = "no";
          target_preserve = "20d 10w *m";

          volume = {
            "ssh://homeassistant.home.arpa/data/butter" = {
              snapshot_dir = "@snapshots";
              target = "/media/btrbk/snapshots_homeassistant";
              subvolume = {
                "@nixos" = { };
                "@nixos/srv" = { };
                "@nixos/var" = { };
                "@home" = { };
              };
            };
          };
        };
      };
    };
  };
}
