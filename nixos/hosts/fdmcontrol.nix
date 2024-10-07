{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    ../boot/extlinux.nix
    ../cli.nix
    ../locale/pl.nix
    ../network/networkmanager.nix
    ../various/adguard.nix
    ../various/klipper/default.nix
    ../various/zram.nix
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    initrd.availableKernelModules = ["xhci_pci"];
    initrd.kernelModules = [];
    kernelModules = [];
    extraModulePackages = [];
  };

  environment = {
    etc.machine-id.text = "326361ad04094a9b86bd130186912b6f\n";
    systemPackages = [pkgs.libraspberrypi];
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/44444444-4444-4444-8888-888888888888";
    fsType = "ext4";
  };

  # hardware = {
  #   raspberry-pi."4".apply-overlays-dtmerge.enable = true;
  #   deviceTree = {
  #     enable = true;
  #     filter = "*rpi-4-*.dtb";
  #   };
  # };

  networking.hostName = "fdmcontrol";

  nixpkgs.hostPlatform = "aarch64-linux";
  nixpkgs.overlays = [
    (final: prev: {
      # fails to compile with gcc 13
      klipper-firmware = prev.klipper-firmware.override {
        gcc-arm-embedded = prev.gcc-arm-embedded-11;
      };
      # missing libgpiod python package
      moonraker = let
        moonrakerPythonEnv = prev.python3.withPackages (
          packages:
            with packages; [
              tornado
              pyserial-asyncio
              pillow
              lmdb
              streaming-form-data
              distro
              inotify-simple
              libnacl
              paho-mqtt
              pycurl
              zeroconf
              preprocess-cancellation
              jinja2
              dbus-next
              apprise
              python-periphery
              ldap3
              libgpiod
            ]
        );
      in
        prev.moonraker.overrideAttrs {
          installPhase = ''
            mkdir -p $out $out/bin $out/lib
            cp -r moonraker $out/lib

            makeWrapper ${moonrakerPythonEnv}/bin/python $out/bin/moonraker \
              --add-flags "$out/lib/moonraker/moonraker.py"
          '';
        };
    })
  ];

  security.sudo.wheelNeedsPassword = false;

  programs.fish.enable = true;

  services = {
    getty.autologinUser = "printer";
    openssh.enable = true;

    # gpio permissions
    udev.extraRules = let
      shell = "/bin/sh -c";
      user = "printer";
      group = "users";
    in ''
      SUBSYSTEM=="bcm2835-gpiomem", KERNEL=="gpiomem", GROUP="${group}",MODE="0660"
      SUBSYSTEM=="gpio", KERNEL=="gpiochip*", ACTION=="add", RUN+="${shell} 'chown ${user}:${group} /sys/class/gpio/export /sys/class/gpio/unexport ; chmod 220 /sys/class/gpio/export /sys/class/gpio/unexport'"
      SUBSYSTEM=="gpio", KERNEL=="gpio*", ACTION=="add",RUN+="${shell} 'chown ${user}:${group} /sys%p/active_low /sys%p/direction /sys%p/edge /sys%p/value ; chmod 660 /sys%p/active_low /sys%p/direction /sys%p/edge /sys%p/value'"
    '';
  };

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

  # I'm tot sure how to change this with udev
  systemd.services."fix-gpiochip-permission" = {
    description = "change permission of /dev/gpiochip0";
    serviceConfig = {
      ExecStart = "/bin/sh -c \"sleep 1; chown printer:users /dev/gpiochip0\"";
      Type = "oneshot";
    };
    wantedBy = ["default.target"];
    wants = ["multi-user.target"];
  };

  users.mutableUsers = false;
  users.users.printer = {
    extraGroups = ["wheel"];
    hashedPasswordFile = "/nix/persist/home/printer/passwd";
    isNormalUser = true;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM73MctM8BEu5LaUwtmK3rxAJCvVAxN4XqEttArbJpAb piotr.fila.stud@pw.edu.pl"
    ];
    packages = [pkgs.git];
    shell = pkgs.fish;
  };
}
