{
  config,
  pkgs,
  ...
}: {
  # home.file = import ../util/persist.nix {
  #   inherit config;
  #   symlinks = [
  #     ".config/GIMP"
  #     ".local/share/gegl-0.4"
  #   ];
  # };
  home.packages = [pkgs.gimp];
}
