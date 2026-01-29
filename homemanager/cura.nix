{
  config,
  pkgs,
  ...
}: let
  util = import ../util.nix;
in {
  home = {
    packages = [pkgs.cura];
    persistence = util.persist {
      inherit config;
      directories = [
        ".config/cura"
        ".local/share/cura"
      ];
    };
  };
}
