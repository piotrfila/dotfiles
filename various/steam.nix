{...}: {
  home-manager.users.kaliko = {pkgs, ...}: {
    home.packages = with pkgs; [
      steam
      steam-run
      # wineWowPackages.staging
    ];
  };

  programs.steam = {
    enable = true;
    # remotePlay.openFirewall = true;
    # dedicatedServer.openFirewall = true;
  };
}
