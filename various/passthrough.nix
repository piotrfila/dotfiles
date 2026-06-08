{
  pkgs,
  lib,
  config,
  ...
}: {
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
  };

  environment = {
    # set max locked ram to 20 GiB (not working currently)
    etc."security/limits.conf".text = ''
      @kvm	hard	memlock	21474836480
      @kvm	soft	memlock	21474836480
    '';

    systemPackages = [pkgs.virt-viewer pkgs.qemu_kvm];
  };

  programs.virt-manager = {
    enable = true;
    package = pkgs.virt-manager;
  };

  users.users.kaliko.extraGroups = ["libvirtd"];

  virtualisation = {
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
  };
}
