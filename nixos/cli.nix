{ config, lib, pkgs, ... }: {
  boot.kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;
  boot.consoleLogLevel = lib.mkDefault 1;

  console = {
    font = "Lat2-Terminus16";
    keyMap = "pl2";
  };

  environment = {
    defaultPackages = [ ];

    etc."current-system-packages".text =
      let
      packages = builtins.map (p: "${p.name}") config.environment.systemPackages;
      sortedUnique = builtins.sort builtins.lessThan (lib.unique packages);
      formatted = builtins.concatStringsSep "\n" sortedUnique;
      in
      formatted; 
    
    etc."nixos/configuration.nix".text = lib.mkDefault "{ ... }: { imports = [ /nix/persist/home/${config.services.getty.autologinUser}/Source/dotfiles/nixos/hosts/${config.networking.hostName}.nix ]; }";

    sessionVariables = rec {
      # XDG
      XDG_CACHE_HOME = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME = "$HOME/.local/share";
      XDG_STATE_HOME = "$HOME/.local/state";

      # XDG fixes
      GNUPGHOME = "$XDG_DATA_HOME/gnupg";
      HISTFILE = "$XDG_STATE_HOME/bashhst";
      WINEPREFIX = "$XDG_DATA_HOME/wine";
      GTK2_RC_FILES = "$XDG_CONFIG_HOME/gtk-2.0/gtkrc";
      GRC_PREFS_PATH = "$XDG_CONFIG_HOME/GNU Radio/";
    };

    shellAliases = {
      la = "ls -lAh";
      neofetch = "fastfetch";
      python = "python3";
      ssh = "TERM=xterm ssh";
      untar = "tar -xvf";
      wget = "wget --hsts-file=$XDG_DATA_HOME/wget-hsts";
    };

    systemPackages = [ pkgs.nano ];
  };

  networking.firewall.enable = lib.mkDefault false;

  nix.settings = {
    # auto-optimise-store = true;
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = [ "@wheel" "root" ];
  };
  nix.extraOptions = "use-xdg-base-directories = true";
  
  nixpkgs.config.allowUnfree = lib.mkDefault true;

  security.polkit = {
    enable = true;
    extraConfig = ''
      polkit.addRule(function(action, subject) {
        if (subject.isInGroup("wheel") && (
          action.id == "org.freedesktop.login1.reboot" ||
          action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
          action.id == "org.freedesktop.login1.power-off" ||
          action.id == "org.freedesktop.login1.power-off-multiple-sessions"
        )) {    
          return polkit.Result.YES
        }
      })
    '';
  };

  services.fstrim.enable = lib.mkDefault true;

  system.copySystemConfiguration = lib.mkDefault true;

  time.timeZone = "Europe/Warsaw";
}
