{
  config,
  pkgs,
  ...
}: let
  util = import ../util.nix;
  histfile_path = ".local/state/pythonhst";
in {
  home.packages = [
    (pkgs.python3.withPackages (ps: [
      ps.pyserial
      ps.tkinter
    ]))
  ];
  home.persistence = util.persist {
    inherit config;
    files = [histfile_path];
  };
  home.sessionVariables = {PYTHON_HISTORY = histfile_path;};
}
