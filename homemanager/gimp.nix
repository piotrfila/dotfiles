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
      ".config/GIMP"
      ".local/share/gegl-0.4"
    ];
  };
  home.packages = [pkgs.gimp3];
}
