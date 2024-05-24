{ ... }: {
  networking = {
    dhcpcd.enable = false;
    nameservers = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];
  };

  services.resolved = {
    enable = true;
    dnssec = "true";
    fallbackDns = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];
    extraConfig = ''
      DNSOverTLS=yes
    '';
  };

  systemd.network = {
    wait-online.enable = false;
    enable = true;
  };
}