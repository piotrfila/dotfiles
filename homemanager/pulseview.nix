{
  config,
  pkgs,
  ...
}: let
  util = import ../util.nix;
in {
  home.persistence = util.persist {
    inherit config;
    files = [".config/sigrok/PulseView.conf"];
  };
  home.packages = [pkgs.pulseview];
}
