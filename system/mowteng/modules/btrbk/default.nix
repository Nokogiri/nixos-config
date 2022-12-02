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
    };
  };
}
