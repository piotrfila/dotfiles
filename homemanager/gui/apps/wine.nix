{
  config,
  pkgs,
  ...
}: let
  util = import ../../../util.nix;
in {
  home = {
    packages = with pkgs; [
      mono
      winetricks
      wineWow64Packages.stable
    ];
    persistence = util.persist {
      inherit config;
      directories = [".local/share/wine"];
    };
    sessionVariables.WINEPREFIX = "/nix/persist${config.xdg.dataHome}/wine";
  };
}
