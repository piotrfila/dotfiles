{
  config,
  pkgs,
  ...
}: let
  util = import ../util.nix;
in {
  home = {
    packages = [pkgs.kicad-small];
    persistence = util.persist {
      inherit config;
      directories = [
        ".config/kicad"
        ".local/share/kicad"
      ];
    };
  };
}
