{
  pkgs,
  config,
  ...
}: let
  secrets = import ../../../secrets.nix;
  util = import ../../../util.nix;
  factorio-pkg = pkgs.factorio-space-age.override {
    username = secrets.factorio.username;
    token = secrets.factorio.token;
  };
in
  if secrets.factorio != null
  then {
    home = {
      packages = [factorio-pkg];

      persistence = util.persist {
        inherit config;
        directories = [
          ".factorio"
        ];
      };
    };
  }
  else {}
