{
  config,
  lib,
  modulesPath,
  pkgs,
  ...
}: let
  impermanence = builtins.fetchTarball "https://github.com/nix-community/impermanence/archive/69ca099e5318bd9c12bc67211cbb23c4c3643b2b.tar.gz";
in {
  imports = [
    "${impermanence}/nixos.nix"
    ./common.nix
    ../gui
    ../network/systemd-eth0.nix
    ../users/kaliko.nix
    <home-manager/nixos>
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    binfmt.emulatedSystems = ["aarch64-linux" "riscv64-linux"];
    extraModulePackages = [];
    kernelModules = ["kvm-intel"];
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };
    initrd.availableKernelModules = ["ahci" "nvme" "xhci_pci"];
    initrd.kernelModules = [];
  };

  environment = {
    persistence."/nix/persist" = {
      hideMounts = true;
      directories = [
        "/etc/mullvad-vpn"
        "/root"
        "/var/log"
        "/var/lib/alsa"
        "/var/lib/nixos"
        "/var/lib/private/ollama"
        "/var/lib/private/open-webui"
        "/var/lib/systemd"
      ];
    };
    etc.machine-id.text = "a6b226f9843b43d5986bf217c96009d0\n";
    systemPackages = [pkgs.ntfs3g];
  };

  fileSystems = {
    "/" = {
      device = "tmpfs";
      fsType = "tmpfs";
      options = ["size=4G" "mode=755"];
    };
    "/home/kaliko" = {
      device = "tmpfs";
      fsType = "tmpfs";
      options = ["size=32G" "mode=777"];
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/4444-3E58";
      fsType = "vfat";
      options = ["fmask=0022" "dmask=0022" "noatime"];
    };
    "/nix" = {
      device = "/dev/disk/by-uuid/6c5dd40d-7e9a-4402-b14b-2cad05e39385";
      fsType = "ext4";
      options = ["noatime"];
    };
    # "/export/vol1" = {
    #   device = "/nix/server";
    #   options = ["bind"];
    # };
  };

  hardware = {
    cpu.intel.updateMicrocode = true;
    enableRedistributableFirmware = true;
    graphics.enable = true;
  };

  networking = {
    hostName = "homelab";
    useNetworkd = true;
  };

  nixpkgs.hostPlatform = "x86_64-linux";

  programs = {
    fuse.userAllowOther = true;
    # steam = {
    #   enable = true;
    # remotePlay.openFirewall = true;
    # dedicatedServer.openFirewall = true;
    # };
  };

  services = {
    getty.autologinUser = "kaliko";
    mullvad-vpn.enable = true;
    nfs.server = {
      enable = true;
      exports = ''
        /export        192.168.1.2(rw,fsid=0,no_subtree_check)
        /export/vol1   192.168.1.2(rw,nohide,insecure,no_subtree_check)
      '';
    };
    # ollama = {
    #   enable = true;
    #   package = pkgs.ollama-cuda;
    # };
    # open-webui = {
    #   enable = true;
    #   environment = {
    #     "ANONYMIZED_TELEMETRY" = "False";
    #     "DO_NOT_TRACK" = "True";
    #     "SCARF_NO_ANALYTICS" = "True";
    #     "TZ" = "Europe/Warsaw";
    #     "OLLAMA_API_BASE_URL" = "http://127.0.0.1:11434/api";
    #     "OLLAMA_BASE_URL" = "http://127.0.0.1:11434";
    #     "WEBUI_AUTH" = "False";
    #   };
    # };
  };

  specialisation = let
    nvidia_base = {
      modesetting.enable = true;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
    };
  in {
    nvidia-proprietary.configuration = {
      system.nixos.tags = ["nvidia-proprietary"];
      hardware.nvidia = nvidia_base // {open = false;};
      services.xserver.videoDrivers = ["nvidia"];
    };
    nvidia-semifree.configuration = {
      system.nixos.tags = ["nvidia-semifree"];
      hardware.nvidia = nvidia_base // {open = true;};
      services.xserver.videoDrivers = ["nvidia"];
    };
    vfio-passthrough.configuration = let
      vfioIDs = [
        "10de:13c2" # GTX 970 Graphics
        "10de:0fbb" # GTX 970 Audio
        "10de:1b80" # GTX 1080 Graphics
        "10de:10f0" # GTX 1080 Audio
        "10de:2203" # RTX 4060 Ti Graphics
        "10de:28bd" # RTX 4060 Ti Audio
        "1b21:1242" # Secondary USB controller
      ];
    in {
      system.nixos.tags = ["vfio-passthrough"];
      imports = [../various/passthrough.nix];
      boot.kernelParams = [
        "intel_iommu=on"
        ("vfio-pci.ids=" + lib.concatStringsSep "," vfioIDs)
      ];
    };
  };

  system.stateVersion = "23.11";

  systemd.network.links."10-eth0" = {
    matchConfig.MACAddress = "d8:cb:8a:9b:96:6a";
    linkConfig.Name = "eth0";
  };

  users.users.kaliko.extraGroups = ["i2c"];
}
