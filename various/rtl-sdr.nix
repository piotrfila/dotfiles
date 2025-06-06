{pkgs, ...}: {
  boot.blacklistedKernelModules = ["dvb_usb_rtl28xxu"];
  hardware.rtl-sdr.enable = true;
  services.udev.packages = [pkgs.rtl-sdr];
  environment.systemPackages = [pkgs.rtl-sdr];
}
