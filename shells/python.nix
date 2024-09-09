{pkgs ? import <nixpkgs> {}}: let
  my-python-packages = ps:
    with ps; [
      certifi
      charset-normalizer
      matplotlib
      numpy
      opencv4
      pandas
      pillow
      pygame
      pyserial
      python-dateutil
      pyyaml
      requests
      scikit-learn
      selenium
      typing-extensions
      urllib3
    ];
  my-python = pkgs.python3.withPackages my-python-packages;
in
  my-python.env
