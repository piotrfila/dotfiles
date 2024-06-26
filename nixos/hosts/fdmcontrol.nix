{ config, lib, pkgs, modulesPath, ... }: {
  imports = [
    ../boot/extlinux.nix
    ../cli.nix
    ../locale/pl.nix
    ../network/systemd-wireless.nix
    ../various/klipper/default.nix
    ../various/zram.nix
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    initrd.availableKernelModules = [ "xhci_pci" ];
    initrd.kernelModules = [ ];
    kernelModules = [ ];
    extraModulePackages = [ ];
  };

  environment = {
    etc.machine-id.text = "326361ad04094a9b86bd130186912b6f\n";
    systemPackages = [ pkgs.libraspberrypi ];
  };

  fileSystems = {
    # "/" = {
    #   device = "tmpfs";
    #   fsType = "tmpfs";
    #   options = [ "size=32G" "mode=755" ];
    # };
    "/" = {
      device = "/dev/disk/by-uuid/44444444-4444-4444-8888-888888888888";
      fsType = "ext4";
    };
  };
#     "/boot" = {
#       device = "/nix/boot";
#       fsType = "none";
#       options = [ "bind" ];
#     };
#   } // (builtins.listToAttrs (
#     builtins.map ( x: {
#       name = x;
#       value = {
#         device = "/nix/persist${x}";
#         fsType = "none";
#         options = [ "bind" ];
#       };
#     }) [
#       "/root"
#       "/home"
#       #"/var/log"
#       #"/var/lib/nixos"
#       #"/var/lib/systemd/coredump"
#     ]
#   ));

  networking.hostName = "fdmcontrol";
  # networking.interfaces.end0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlan0.useDHCP = lib.mkDefault true;
  networking.useDHCP = lib.mkDefault true;
  networking.wireless.enable = true;

  nixpkgs.hostPlatform = "aarch64-linux";

  security.sudo.wheelNeedsPassword = false;

  services = {
    getty.autologinUser = "printer";
    openssh.enable = true;
  };

  programs.fish.enable = true;

  system.stateVersion = "24.05";

  systemd.network.links = {
    "10-eth0" = {
      matchConfig.MACAddress = "e4:5f:01:4b:cb:7a";
      linkConfig.Name = "eth0";
    };
    "15-wlan0" = {
      matchConfig.MACAddress = "e4:5f:01:4b:cb:7b";
      linkConfig.Name = "wlan0";
    };
  };

  swapDevices = [ ];

  users.mutableUsers = false;
  users.users.printer = {
    extraGroups = [ "wheel" ];
    hashedPasswordFile = "/nix/persist/home/printer/passwd";
    isNormalUser = true;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM73MctM8BEu5LaUwtmK3rxAJCvVAxN4XqEttArbJpAb piotr.fila.stud@pw.edu.pl"
    ];
    packages = [ pkgs.git ];
    shell = pkgs.fish;
  };

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 75;
  };
}