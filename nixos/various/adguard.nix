{...}: {
  services.adguardhome = {
    enable = true;
    settings = {
      https.address = "127.0.0.1:3003";
      dns.upstream_dns = [
        "https://doh.libredns.gr/noads"
        "tls://noads.libredns.gr"
        "tls://116.202.176.26"
        "https://security.cloudflare-dns.com/dns-query"
        "tls://security.cloudflare-dns.com"
        "https://dns.quad9.net/dns-query"
        "tls://dns.quad9.net"
        "https://dns.adguard.com/dns-query"
        "tls://dns.adguard.com"
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
