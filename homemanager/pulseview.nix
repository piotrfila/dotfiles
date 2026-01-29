{
  config,
  pkgs,
  ...
}: let
  util = import ../util.nix;
in {
  home = {
    packages = [pkgs.pulseview];
    persistence = util.persist {
      inherit config;
      files = [".config/sigrok/PulseView.conf"];
    };
  };
}
