{ ... }: {
  networking.wireless = {
    enable = true;

    # wi-fi passwords
    environmentFile = "/nix/persist/wireless.env";

    networks = {
      "Pixel_4710" = {
        priority = 30;
        psk = "@PSK_Pixel_4710@";
      };
      "siec1" = {
        priority = 10;
        psk = "@PSK_siec1@";
      };
      "siec2_25" = {
        priority = 20;
        psk = "@PSK_siec2@";
      };
      "siec2_50" = {
        priority = 25;
        psk = "@PSK_siec2@";
      };
    };

    # userControlled.enable = true;
  };
}