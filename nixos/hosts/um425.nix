{ config, lib, pkgs, modulesPath, ... }: {
  imports = [
    # ../binfmt/aarch64.nix
    ../boot/systemd.nix
    ../cli.nix
    # ../cachix/hyprland.nix
    ../gui.nix
    ../locale/pl.nix
    ../network/networkmanager.nix
    ../users/kaliko.nix
    ../various/bluetooth.nix
    ../various/fonts.nix
    # ../various/laserjet2300.nix
    # ../various/steam.nix
    ../various/thunar.nix
    <home-manager/nixos>
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" ];
    initrd.kernelModules = [ ];
    kernelModules = [ "kvm-amd" ];
    extraModulePackages = [ ];
  };

  environment = {
    etc.machine-id.text = "0797e38666bb4669a69854f927d8936f\n";
    systemPackages = [ pkgs.ntfs3g ];
  };

  fileSystems = lib.recursiveUpdate {
    "/" = {
      device = "tmpfs";
      fsType = "tmpfs";
      options = [ "size=32G" "mode=755" ];
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/9F24-380D";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" "noatime" ];
    };

    "/nix" = {
      device = "/dev/disk/by-uuid/1bf92b6d-6db2-42e8-9b26-6341f09808ef";
      fsType = "ext4";
      options = [ "noatime" ];
    };

    # "/home/kaliko/.local/share/Steam" = {
    #   device = "/nix/persist/home/kaliko/.local/share/Steam";
    #   fsType = "none";
    #   options = [ "bind" ];
    # }
  } (builtins.listToAttrs (
    builtins.map ( x: {
      name = x;
      value = {
        device = "/nix/persist${x}";
        fsType = "none";
        options = [ "bind" ];
      };
    }) [
      "/etc/NetworkManager/system-connections"
      # "etc/nixos"
      "/etc/mullvad-vpn"
      "/root"
      "/var/log"
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
    printing = {
      enable = true;
      drivers = [ pkgs.hplipWithPlugin ];
    };
    thermald.enable = false;
    udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="amdgpu_bl1", MODE="0666", RUN+="${pkgs.coreutils-full}/bin/chmod a+w /sys/class/backlight/%k/brightness"
      ATTRS{idVendor}=="0483", ATTRS{idProduct}=="3748", TAG+="uaccess"
    '';
  };

  system.stateVersion = "23.11";

  systemd.services."set-battery-charging-cap" = {
    description = "set maximum battery charging capacity";
    serviceConfig = {
      ExecStart = "/bin/sh -c \"cat /nix/persist/home/kaliko/.config/batt-cap > /sys/class/power_supply/BATT/charge_control_end_threshold\"";
      Type = "oneshot";
    };
    wantedBy = [ "default.target" ];
  };
  
  systemd.services."fix-battery-permission" = {
    description = "change permission of charge_control_end_threshold";
    serviceConfig = {
      ExecStart = "/bin/sh -c \"sleep 1; chmod a+w /sys/class/power_supply/BATT/charge_control_end_threshold\"";
      Type = "oneshot";
    };
    wantedBy = [ "default.target" ];
    wants = [ "multi-user.target" ];
  };

  swapDevices = [ ];

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 75;
  };

  systemd.network.links = {
    "10-eth0" = {
      matchConfig.MACAddress = "0c:37:96:1b:27:d3";
      linkConfig = {
        Name = "eth0";
      };
    };
    "15-wlan0" = {
      matchConfig.MACAddress = "ac:12:03:17:a5:a7";
      linkConfig = {
        Name = "wlan0";
      };
    };        
  };

  # networks = {
  # #   "20-wired" = {
  # #     DHCP = "yes";
  # #     # dhcpV4Config = "RouteMetric=10";
  # #     # ipv6AcceptRAConfig = "RouteMetric=10";
  # #     name = "eth0";
  # #   };
  #   "25-wireless.link" = {
  #     DHCP = "yes";
  #     # dhcpV4Config = "RouteMetric=10";
  #     # ipv6AcceptRAConfig = "RouteMetric=10";
  #     name = "wlan0";
  #   };
  # };
}
