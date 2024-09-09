let
  vfioIDs = [
    "10de:13c2" # Gtx 970 Graphics
    "10de:0fbb" # Gtx 970 Audio
    "1b21:1242" # Secondary USB controller
  ];
in { pkgs, lib, config, ... }: {
  boot = {
    blacklistedKernelModules = [
      "nvidiafb"
      "nouveau"
    ];

    initrd.kernelModules = [
      "vfio_pci"
      "vfio"
      "vfio_iommu_type1"
      #"vfio_virqfd"
    ];

    kernelParams = [
      # enable IOMMU
      "intel_iommu=on"
      ("vfio-pci.ids=" + lib.concatStringsSep "," vfioIDs)
    ];
  };

  # set max locked ram to 20 GiB (not working currently)
  environment = {
    etc."security/limits.conf".text = ''
      @kvm	hard	memlock	21474836480
      @kvm	soft	memlock	21474836480
    '';

    systemPackages = [ pkgs.virt-viewer ];
  };

  programs.virt-manager.enable = true;

  virtualisation = {
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
  };
}