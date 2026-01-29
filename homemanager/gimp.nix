{
  config,
  pkgs,
  ...
}: let
  util = import ../util.nix;
in {
  home = {
    packages = [pkgs.gimp3];
    persistence = util.persist {
      inherit config;
      directories = [
        ".config/GIMP"
        ".local/share/gegl-0.4"
      ];
    };
  };
}
