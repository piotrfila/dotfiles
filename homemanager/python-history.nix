{config, ...}: let
  util = import ../util.nix;
  hstfile = "pythonhst";
in {
  home.persistence = util.persist {
    inherit config;
    files = [".local/state/${hstfile}"];
  };
  home.file.".config/pythonrc.py".text = ''
    def is_vanilla() -> bool:
        import sys
        return not hasattr(__builtins__, '__IPYTHON__') and 'bpython' not in sys.argv[0]

    def setup_history():
        import atexit
        import os
        import readline
        from pathlib import Path

        state_home = os.environ.get('XDG_STATE_HOME')
        if state_home:
            state_home = Path(state_home)
        else:
            state_home = Path.home() / '.local' / 'state'

        history: str = f"{str(state_home)}/${hstfile}"

        if not os.path.exists(history):
            open(history, "w")

        readline.read_history_file(history)
        atexit.register(readline.write_history_file, history)

    if is_vanilla():
        setup_history()
  '';
}
