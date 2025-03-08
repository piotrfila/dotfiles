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
    ../locale.nix
    ../network/networkmanager.nix
    ../users/kaliko.nix
    ../various/bluetooth.nix
    ../various/fcitx.nix
    ../various/fonts.nix
    ../various/logind.nix
    ../various/nix-ld.nix
    ../various/rtl-sdr.nix
    ../various/thunar.nix
    ../various/zram.nix
    <home-manager/nixos>
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    initrd.availableKernelModules = ["ahci" "nvme" "xhci_pci"];
    initrd.kernelModules = [];
    kernelModules = ["kvm-amd"];
    extraModulePackages = [];
    binfmt.emulatedSystems = ["aarch64-linux" "riscv64-linux"];
  };

  environment = {
    etc.machine-id.text = "0797e38666bb4669a69854f927d8936f\n";
    systemPackages = with pkgs; [
      ntfs3g
      wineWowPackages.staging
      winetricks
      wineWowPackages.waylandFull
    ];
  };

  fileSystems =
    {
      "/" = {
        device = "tmpfs";
        fsType = "tmpfs";
        options = ["size=32G" "mode=755"];
      };

      "/boot" = {
        device = "/dev/disk/by-uuid/9F24-380D";
        fsType = "vfat";
        options = ["fmask=0022" "dmask=0022" "noatime"];
      };

      "/nix" = {
        device = "/dev/disk/by-uuid/1bf92b6d-6db2-42e8-9b26-6341f09808ef";
        fsType = "ext4";
        options = ["noatime"];
      };

      "/mnt/homelab" = {
        device = "192.168.1.3:/vol1";
        fsType = "nfs";
        options = ["x-systemd.automount" "x-systemd.idle-timeout=60" "noauto" "noatime"];
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
        "/etc/NetworkManager/system-connections"
        "/etc/mullvad-vpn"
        "/root"
        "/var/log"
        "/var/lib/alsa"
        "/var/lib/bluetooth"
        "/var/lib/nixos"
        "/var/lib/systemd/coredump"
        "/var/lib/cups"
      ]
    ));

  hardware.cpu.amd.updateMicrocode = true;
  hardware.enableRedistributableFirmware = true;

  networking.hostName = "um425";

  nixpkgs.hostPlatform = "x86_64-linux";

  programs = {
    adb.enable = true;
    dconf.enable = true;
    fish.enable = true;
    hyprland = {
      enable = true;
      package = pkgs.hyprland;
      xwayland.enable = true;
    };
  };

  services = {
    auto-cpufreq = {
      enable = true;
      settings = {
        battery = {
          governor = "powersave";
          turbo = "never";
        };
        charger = {
          governor = "performance";
          turbo = "auto";
        };
      };
    };
    getty.autologinUser = "kaliko";
    mullvad-vpn.enable = true;
    printing.enable = true;
    thermald.enable = false;
    udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="amdgpu_bl1", MODE="0666", RUN+="${pkgs.coreutils-full}/bin/chmod a+w /sys/class/backlight/%k/brightness"
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="3748", MODE:="0666", SYMLINK+="stlinkv2-1_%n"
      SUBSYSTEM=="usb", ATTRS{idVendor}=="10c4", MODE="0666"
      SUBSYSTEM=="tty", ATTRS{idVendor}=="10c4", MODE="0666"
    '';
  };

  system.stateVersion = "23.11";

  systemd.services."set-battery-charging-cap" = {
    description = "set maximum battery charging capacity";
    serviceConfig = {
      ExecStart = "/bin/sh -c \"cat /nix/persist/home/kaliko/.config/batt-cap > /sys/class/power_supply/BATT/charge_control_end_threshold\"";
      Type = "oneshot";
    };
    wantedBy = ["default.target"];
  };

  systemd.services."fix-battery-permission" = {
    description = "change permission of charge_control_end_threshold";
    serviceConfig = {
      ExecStart = "/bin/sh -c \"sleep 1; chmod a+w /sys/class/power_supply/BATT/charge_control_end_threshold\"";
      Type = "oneshot";
    };
    wantedBy = ["default.target"];
    wants = ["multi-user.target"];
  };

  systemd.network.links = {
    "10-eth0" = {
      linkConfig.Name = "eth0";
      matchConfig.MACAddress = "0c:37:96:1b:27:d3";
    };
    "15-wlan0" = {
      linkConfig.Name = "wlan0";
      matchConfig.MACAddress = "ac:12:03:17:a5:a7";
    };
  };
}
