{
  config,
  pkgs,
  ...
}: let
  util = import ../util.nix;
in {
  # home.file = util.persist {
  #   inherit config;
  #   symlinks = [
  #     ".config/GIMP"
  #     ".local/share/gegl-0.4"
  #   ];
  # };
  home.packages = [pkgs.gimp];
}
