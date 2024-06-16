{ ... }: {
  services = {
    klipper = {
      enable = true;
      configFile = ./printer-creality-ender3-v2-2020.cfg;
      # firmwares = {
      #   mcu = {
      #     enable = true;
      #     Run klipper-genconf to generate this
      #     configFile = ./avr.cfg;
      #     Serial port connected to the microcontroller
      #     serial = "/dev/serial/by-id/usb-Arduino__www.arduino.cc__0042_55639303235351D01152-if00";
      #   };
      # };
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