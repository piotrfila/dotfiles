{
  config,
  pkgs,
  ...
}: let
  util = import ../../../util.nix;
in {
  home = {
    packages = [pkgs.localsend];
    persistence = util.persist {
      inherit config;
      directories = [".local/share/org.localsend.localsend_app"];
    };
  };
}
