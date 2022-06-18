{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    (let
      my-ruby-packages = ruby-packages: with ruby-packages; [
        fusuma
      ];
      ruby-with-my-packages = ruby_3_0.withPackages my-ruby-packages;
    in
    ruby-with-my-packages)
  ];
}
