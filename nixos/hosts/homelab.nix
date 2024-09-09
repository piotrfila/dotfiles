{
  config,
  lib,
  modulesPath,
  pkgs,
  ...
}: {
  imports = [
    ../boot/systemd.nix
    ../cli.nix
    ../gui.nix
    ../locale/pl.nix
    ../network/systemd-eth0.nix
    ../users/kaliko.nix
    ../various/fonts.nix
    ../various/logind.nix
    ../various/passthrough.nix
    ../various/thunar.nix
    <home-manager/nixos>
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    initrd.availableKernelModules = ["xhci_pci" "ahci" "nvme"];
    initrd.kernelModules = [];
    kernelModules = ["kvm-intel"];
    extraModulePackages = [];
  };

  environment = {
    etc.machine-id.text = "a6b226f9843b43d5986bf217c96009d0\n";
    systemPackages = [pkgs.ntfs3g];
  };

  fileSystems =
    {
      "/" = {
        device = "tmpfs";
        fsType = "tmpfs";
        options = ["size=32G" "mode=755"];
      };

      "/boot" = {
        device = "/dev/disk/by-uuid/4444-3E58";
        fsType = "vfat";
        options = ["fmask=0022" "dmask=0022"];
      };

      "/nix" = {
        device = "/dev/disk/by-uuid/6c5dd40d-7e9a-4402-b14b-2cad05e39385";
        fsType = "ext4";
      };
    }
    // (builtins.listToAttrs (
      builtins.map (x: {
        name = x;
        value = {
          device = "/nix/persist${x}";
          fsType = "none";
          options = ["bind"];
        };
      }) [
        "/home"
        "/etc/mullvad-vpn"
        "/root"
        "/var/log"
        "/var/lib/alsa"
        "/var/lib/nixos"
        "/var/lib/systemd/coredump"
      ]
    ));

  hardware.cpu.intel.updateMicrocode = true;
  hardware.enableRedistributableFirmware = true;

  networking.hostName = "homelab";

  nixpkgs.hostPlatform = "x86_64-linux";

  programs = {
    dconf.enable = true;
    fish.enable = true;
    hyprland = {
      enable = true;
      package = pkgs.hyprland;
      xwayland.enable = true;
    };
  };

  services = {
    getty.autologinUser = "kaliko";
    mullvad-vpn.enable = true;
  };

  system.stateVersion = "23.11";

  systemd.network.links = {
    "10-eth0" = {
      matchConfig.MACAddress = "d8:cb:8a:9b:96:6a";
      linkConfig = {
        Name = "eth0";
      };
    };
  };
}
