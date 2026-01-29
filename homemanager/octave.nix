{
  config,
  pkgs,
  ...
}: let
  util = import ../util.nix;
in {
  home = {
    packages = [
      (pkgs.octaveFull.withPackages (ps: [
        ps.signal
      ]))
    ];
    persistence = util.persist {
      inherit config;
      directories = [".local/share/octave"];
    };
  };
}
