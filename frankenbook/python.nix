{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    (let
      my-python-packages = python-packages: with python-packages; [
        isort
        nose
        pytest
        requests
        setuptools
      ];
      python-with-my-packages = python3.withPackages my-python-packages;
    in
    python-with-my-packages)
    pipenv
  ];
}

