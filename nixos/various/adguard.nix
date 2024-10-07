{...}: {
  services.adguardhome = {
    enable = true;
    settings = {
      https.address = "127.0.0.1:3003";
      dns.upstream_dns = [
        # Example config with quad9
        "9.9.9.9#dns.quad9.net"
        "149.112.112.112#dns.quad9.net"
      ];
      filtering = {
        protection_enabled = true;
        filtering_enabled = true;

        parental_enabled = false;
        safe_search.enabled = false;
      };
      filters =
        map (url: {
          enabled = true;
          url = url;
        }) [
          "https://adguardteam.github.io/HostlistsRegistry/assets/filter_9.txt" # The Big List of Hacked Malware Web Sites
          "https://adguardteam.github.io/HostlistsRegistry/assets/filter_11.txt" # malicious url blocklist
        ];
    };
  };
}
