{
  config,
  pkgs,
  ...
}: let
  histfile_path = ".local/state/pythonhst";
  util = import ../../util.nix;
in {
  home = {
    packages = [
      (pkgs.python3.withPackages (ps: [
        ps.pyserial
        ps.tkinter
      ]))
    ];
    persistence = util.persist {
      inherit config;
      files = [histfile_path];
    };
    sessionVariables = {PYTHON_HISTORY = histfile_path;};
  };
}
