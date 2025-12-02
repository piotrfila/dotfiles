{
  config,
  pkgs,
  ...
}: let
  util = import ../util.nix;
in {
  home.persistence = util.persist {
    inherit config;
    directories = [
      ".config/cura"
      ".local/share/cura"
    ];
  };
  home.packages = [pkgs.cura];
}
