#
#  Home-manager configuration for desktop
#
#  flake.nix
#   ├─ ./hosts
#   │   └─ ./frankenbook
#   │       └─ ./home.nix
#   └─ ./modules
#       └─ ./desktop
#           └─ ./sway
#               └─ home.nix
#

{ pkgs, ... }:

{
  #imports = 
  #[
  #  ../../modules/desktop/sway/home.nix
  #];

  home = {
    packages = woth pkgs;
    [
    #Apps
    gimp
      inkscape
      gtk-pipe-viewer
      pipe-viewer
      zathura
      imv
      mpv
      ncspot

      #Games

      (polymc.override { msaClientID = "0b5d07b7-fcd2-4f81-901a-7596869a0cee";
  })
  ];
};

services = {                            # Applets
blueman-applet.enable = true;         # Bluetooth
};
}
