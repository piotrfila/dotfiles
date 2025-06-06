{
  config,
  pkgs,
  ...
}: let
  util = import ../util.nix;
in {
  home.file = util.persist {
    inherit config;
    symlinks = [".config/Mullvad VPN"];
  };
  home.packages = [pkgs.mullvad-vpn];
}
