{
  pkgs,
  ...
}: {
  services = {
    klipper = {
      apiSocket = "/run/klipper/api";
      enable = true;
      configFile = ./printer-creality-ender3-v2-2020.cfg;
      firmwares = {
        mcu = {
          enable = true;
          enableKlipperFlash = false;
          configFile = ./board-stm32.cfg;
          serial = "/dev/serial/by-id/usb-1a86_USB_Serial-if00-port0";
        };
      };
      inputTTY = "/run/klipper/tty";
      logFile = "/var/lib/klipper/klipper.log";
      user = "printer";
      group = "users";
    };
    moonraker = {
      address = "0.0.0.0";
      enable = true;
      klipperSocket = "/run/klipper/api";
      settings = {
        octoprint_compat = {};
        history = {};
        authorization = {
          force_logins = true;
          cors_domains = [
            "*.local"
            "*.lan"
            "*://app.fluidd.xyz"
            "*://my.mainsail.xyz"
          ];
          trusted_clients = [
            "10.0.0.0/8"
            "127.0.0.0/8"
            "169.254.0.0/16"
            "172.16.0.0/12"
            "192.168.1.0/24"
            "FE80::/10"
            "::1/128"
          ];
        };

        "power printer" = {
          type = "gpio";
          pin = "!gpiochip0/gpio24";
          off_when_shutdown = true;
          initial_state = "off";
          bound_services = "klipper";
        };
        "power lights" = {
          type = "gpio";
          pin = "!gpiochip0/gpio23";
          initial_state = "off";
        };
      };
      user = "printer";
    };

    mainsail = {
      enable = true;
    };

    udev.extraRules = ''
      SUBSYSTEM=="bcm2835-gpiomem", KERNEL=="gpiomem", GROUP="users",MODE="0666"
      SUBSYSTEM=="gpio", KERNEL=="gpiochip*", ACTION=="add", RUN+="${pkgs.bash}/bin/bash -c 'chown root:users /sys/class/gpio/export /sys/class/gpio/unexport ; chmod 666 /sys/class/gpio/export /sys/class/gpio/unexport'"
      SUBSYSTEM=="gpio", KERNEL=="gpio*", ACTION=="add",RUN+="${pkgs.bash}/bin/bash -c 'chown root:users /sys%p/active_low /sys%p/direction /sys%p/edge /sys%p/value ; chmod 666 /sys%p/active_low /sys%p/direction /sys%p/edge /sys%p/value'"
    '';
  };
}
