{
  pkgs,
  lib,
  config,
  ...
}: let
  vfioIDs = [
    # "10de:13c2" # GTX 970 Graphics
    # "10de:0fbb" # GTX 970 Audio
    "10de:1b80" # GTX 1080 Graphics
    "10de:10f0" # GTX 1080 Audio
    "1b21:1242" # Secondary USB controller
  ];
in {
  # Make sure vt-x and vt-d are enabled!
  boot = {
    blacklistedKernelModules = [
      "nvidiafb"
      "nouveau"
    ];

    initrd.kernelModules = [
      "vfio_pci"
      "vfio"
      "vfio_iommu_type1"
    ];

    kernelParams = [
      "intel_iommu=on"
      ("vfio-pci.ids=" + lib.concatStringsSep "," vfioIDs)
    ];
  };

  environment = {
    # set max locked ram to 20 GiB (not working currently)
    etc."security/limits.conf".text = ''
      @kvm	hard	memlock	21474836480
      @kvm	soft	memlock	21474836480
    '';

    systemPackages = [pkgs.virt-viewer];
  };

  programs.virt-manager.enable = true;

  users.users.kaliko.extraGroups = ["libvirtd"];

  virtualisation = {
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
  };
}
