#!/bin/sh
nix-channel --add https://nixos.org/channels/nixos-25.11 nixos
nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable
nix-channel --add https://github.com/nix-community/home-manager/archive/release-25.11.tar.gz home-manager
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager-unstable
nix-channel --update
