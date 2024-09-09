{lib, ...}: {
  boot.loader = {
    grub.enable = false;
    generic-extlinux-compatible.enable = true;
    timeout = lib.mkDefault 1;
  };
}
