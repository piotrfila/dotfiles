{
  config,
  pkgs,
  ...
}: let
  util = import ../util.nix;
in {
  home.packages = with pkgs; [
    steam
    steam-run
  ];
  # TODO: impersistence
}
