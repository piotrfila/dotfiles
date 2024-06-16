{ ... }: {
  services = {
    klipper = {
      enable = true;
      configFile = ./printer-creality-ender3-v2-2020.cfg;
      firmwares = {
        mcu = {
          enable = true;
          configFile = ./board-stm32.cfg;
          serial = "/dev/serial/by-id/usb-1a86_USB_Serial-if00-port0";
        };
      };
    };
    moonraker = {
      address = "0.0.0.0";
      enable = true;
      settings = {
        octoprint_compat = { };
        history = { };
        authorization = {
          force_logins = true;
          cors_domains = [
            "*.local"
            "*.lan"
            "*://app.fluidd.xyz"
            "*://my.mainsail.xyz"
          ];
          trusted_clients = [
            "127.0.0.0/8"
            "192.168.1.0/24"
          ];
        };
      };
      user = "printer";
    };

    mainsail = {
      enable = true;
    };
  };
}