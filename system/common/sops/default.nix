{ config, pkgs, lib, ... }:

{
  sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
  sops.defaultSopsFile = ./../../../secrets/${config.networking.hostName}.yaml;
}
