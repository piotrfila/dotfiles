{
  config,
  lib,
  pkgs,
  ...
}: {
  boot = {
    kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;
    consoleLogLevel = lib.mkDefault 1;
    loader = {
      grub.enable = lib.mkDefault false;
      systemd-boot = {
        configurationLimit = 40;
        editor = false;
      };
      timeout = lib.mkDefault 1;
    };
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "pl2";
  };

  environment = {
    defaultPackages = [];

    etc."current-system-packages".text = builtins.concatStringsSep "\n" (
      builtins.sort builtins.lessThan (lib.unique (
        builtins.map (p: "${p.name}") config.environment.systemPackages
      ))
    );

    etc."nixos/configuration.nix".text = let
      source = "/home/${config.services.getty.autologinUser}/Source";
    in
      lib.mkDefault ''
        { ... }: {
          imports = [
            ${source}/dotfiles/hosts/${config.networking.hostName}.nix
          ];
        }
      '';

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
      ssh = "TERM=xterm /run/current-system/sw/bin/ssh";
      untar = "tar -xvf";
      wget = "wget --hsts-file=$XDG_DATA_HOME/wget-hsts";
    };

    systemPackages = [pkgs.nano];
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = let
      locale = "pl_PL.UTF-8";
    in {
      LC_ADDRESS = locale;
      LC_IDENTIFICATION = locale;
      LC_MEASUREMENT = locale;
      LC_MONETARY = locale;
      LC_NAME = locale;
      LC_NUMERIC = locale;
      LC_PAPER = locale;
      LC_TELEPHONE = locale;
      LC_TIME = locale;
    };
    supportedLocales = [
      "C.UTF-8/UTF-8"
      "en_US.UTF-8/UTF-8"
      "pl_PL.UTF-8/UTF-8"
      "ja_JP.UTF-8/UTF-8"
    ];
  };

  networking.firewall.enable = lib.mkDefault false;

  nix.settings = {
    auto-optimise-store = true;
    experimental-features = ["nix-command" "flakes"];
    trusted-users = ["@wheel" "root"];
  };
  nix.extraOptions = "use-xdg-base-directories = true";

  nixpkgs.config.allowUnfree = lib.mkDefault true;

  programs.fish.enable = true;

  security.polkit = {
    enable = true;
    extraConfig = ''
      polkit.addRule(function(action, subject) {
        if (subject.isInGroup("wheel") && (
          action.id == "org.freedesktop.systemd1.manage-units" ||
          action.id == "org.freedesktop.login1.power-off" ||
          action.id == "org.freedesktop.login1.power-off-multiple-sessions" ||
          action.id == "org.freedesktop.login1.reboot" ||
          action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
          action.id == "org.freedesktop.login1.halt" ||
          action.id == "org.freedesktop.login1.halt-multiple-sessions"
        )) {
          return polkit.Result.YES
        }
      })
    '';
  };

  services = {
    auto-cpufreq = {
      enable = true;
      settings = {
        battery = {
          governor = "powersave";
          turbo = "never";
        };
        charger = {
          governor = "performance";
          turbo = "auto";
        };
      };
    };
    fstrim.enable = lib.mkDefault true;
    logind.settings.Login = {
      HandleHibernateKey = "ignore";
      HandleHibernateKeyLongPress = "ignore";

      HandlePowerKey = "ignore";
      HandlePowerKeyLongPress = "ignore";

      HandleSuspendKey = "ignore";
      HandleSuspendKeyLongPress = "ignore";

      HandleRebootKey = "ignore";
      HandleRebootKeyLongPress = "ignore";

      HandleLidSwitch = "suspend";
      HandleLidSwitchDocked = "suspend";
      HandleLidSwitchExternalPower = "suspend";
    };
  };

  system.copySystemConfiguration = lib.mkDefault true;

  time.timeZone = "Europe/Warsaw";

  users.mutableUsers = false;

  zramSwap = {
    enable = lib.mkDefault true;
    algorithm = lib.mkDefault "zstd";
    memoryPercent = 75;
  };
}
