{ ... }: {
    home.file.".config/pythonrc.py".text = ''
    def is_vanilla() -> bool:
        import sys
        return not hasattr(__builtins__, '__IPYTHON__') and 'bpython' not in sys.argv[0]


    def setup_history():
        import os
        import atexit
        import readline
        from pathlib import Path

        state_home = os.environ.get('XDG_STATE_HOME')
        if state_home:
            state_home = Path(state_home)
        else:
            state_home = Path.home() / '.local' / 'state'

        history: str = f"/nix/persist{str(state_home)}/python_history"
        
        if not os.path.exists(history):
            open(history, "w")

        readline.read_history_file(history)
        atexit.register(readline.write_history_file, history)


    if is_vanilla():
        setup_history()
    '';
}