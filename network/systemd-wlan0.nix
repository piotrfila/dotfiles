{...}: {
  networking.interfaces.wlan0.useDHCP = true;
  networking.wireless = {
    enable = true;

    # wi-fi passwords
    secretsFile = "/nix/persist/wireless.env";

    networks = {
      "Pixel_4710" = {
        priority = 30;
        pskRaw = "ext:PSK_Pixel_4710";
      };
      "siec1" = {
        priority = 10;
        pskRaw = "ext:PSK_siec1";
      };
      "siec2_25" = {
        priority = 20;
        pskRaw = "ext:PSK_siec2";
      };
      "siec2_50" = {
        priority = 25;
        pskRaw = "ext:PSK_siec2";
      };
    };
  };
}
