{
  config,
  pkgs,
  ...
}: let
  util = import ../util.nix;
in {
  home.file = util.persist {
    inherit config;
    symlinks = [".config/sigrok/PulseView.conf"];
  };
  home.packages = [pkgs.pulseview];
}
