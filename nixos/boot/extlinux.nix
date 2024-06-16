{ lib, ... }: {
  boot.loader = {
    grub.enable = false;
    boot.loader.generic-extlinux-compatible.enable = true;
    timeout = lib.mkDefault 1;
  };      
}
