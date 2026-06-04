{
  config,
  pkgs,
  ...
}: let
  util = import ../../../util.nix;
in {
  home.persistence = util.persist {
    inherit config;
    files = [".config/keepassxc"];
  };
  programs.keepassxc = {
    enable = true;
    autostart = true;
  };
}
