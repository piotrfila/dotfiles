{lib, ...}: {
  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot = {
      configurationLimit = 40;
      editor = false;
      enable = true;
    };
    timeout = lib.mkDefault 1;
  };
}
