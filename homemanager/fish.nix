{config, ...}: let
  util = import ../util.nix;
in {
  home.persistence = util.persist {
    inherit config;
    directories = [".local/share/fish"];
  };
  programs.bash.enable = false;
  programs.fish = {
    enable = true;

    functions = {
      # la = "ls -lAh $argv";
      mkcd = "mkdir $argv[1]; cd $argv[1]";
      mkshell = "nix-shell --run fish ~/Source/dotfiles/shells/$argv[1].nix";
      p = "nix-shell -p --run fish $argv";
      pw = "cd ~/Documents/pw24L";
      fr = "df -h; free -h";
    };

    interactiveShellInit = ''
      set fish_greeting ""
    '';

    loginShellInit = ''
      if test -z $DISPLAY
        and test $(tty) = /dev/tty1
        exec Hyprland
      end
    '';

    plugins = [];
  };
}
