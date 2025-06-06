{...}: {
  networking.interfaces.eth0.useDHCP = true;
  systemd.network = {
    enable = true;
    wait-online.enable = false;
    networks."50-lan" = {
      matchConfig.Name = "eth0";
      networkConfig.DHCP = "yes";
      linkConfig.RequiredForOnline = "no";
    };
  };
}
