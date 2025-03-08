{
  config,
  lib,
  osConfig,
  pkgs,
  ...
}: {
  imports = [
    ./apps/kitty.nix
    ./apps/vscodium.nix
    ./apps/thunar.nix
    ./gui/alacritty.nix
    ./gui/dunst.nix
    ./gui/hyprland.nix
    ./gui/hyprpaper.nix
    ./gui/mime.nix
    ./gui/waybar.nix
    ./gui/wofi.nix
    ./python-history.nix
    ./themes.nix
  ];
  home.file = builtins.listToAttrs (
    builtins.map (x: {
      name = x;
      value = {
        source = config.lib.file.mkOutOfStoreSymlink "/nix/persist${config.home.homeDirectory}/${x}";
      };
    }) ([
        ".config/chromium"
        ".config/fcitx5"
        ".config/hypr/extra.conf"
        ".config/Mullvad VPN"
        ".config/OrcaSlicer"
        ".config/qalculate"
        ".config/Raspberry Pi"
        ".config/spotify"
        ".config/xfce4"
        ".local/share/cargo"
        ".local/share/fish/generated-completions"
        ".local/share/fish/fish_history"
        ".local/share/fish/fonts"
        ".local/share/orca-slicer"
        ".local/share/rustup"
        ".local/share/wine"
        ".local/state/wireplumber"
        ".local/state/python_history"
        "Documents"
        "Downloads"
        "Pictures"
        "Source"
      ]
      ++ (
        if osConfig.networking.hostName == "um425"
        then [
          ".config/calibre"
          ".config/cura"
          ".config/discord"
          ".config/kicad"
          ".config/batt-cap"
          ".local/share/cura"
          ".local/share/kicad"
          ".local/share/PrismLauncher"
        ]
        else []
      ))
  );

  home.packages = with pkgs;
    [
      libnotify
      pavucontrol
      wl-clipboard

      # gui
      libreoffice
      mission-center
      mpv
      mullvad-vpn
      obsidian
      (python3Full.withPackages (ps:
        with ps; [
          pyserial
        ]))
      spotify
      transmission_4-qt
      qalculate-qt
      ungoogled-chromium
      xfce.ristretto

      # cli
      alejandra
      btop
      dnsutils
      git
      fastfetch
      file
      htop
      jq
      killall
      nano
      pciutils
      screen
      unzip
      usbutils
      wget
      xdg-ninja
    ]
    ++ (
      if osConfig.networking.hostName == "um425"
      then [
        calibre
        discord
        # go to factorio.com/profile for the token
        # file homemanager/factorio-credentials.nix should look like this:
        # {
        #   username = "your_username";
        #   token = "0123456789abcdefgijklmnopqrstu";
        # }
        # (factorio.override (import ./factorio-credentials.nix))
        gimp
        kicad
        logisim-evolution
        orca-slicer
        (prismlauncher.override {jdks = [jdk8 jdk17 jdk21];})

        # sdr
        gnuradio
        gqrx

        # verilog
        gnome2.GConf
        gtkwave
        iverilog
        verible
        verilator

        # zig
        zig
        zls
      ]
      else []
    );

  manual.manpages.enable = false;

  programs = {
    bash.enable = false;

    fish = {
      enable = true;

      functions = {
        # la = "ls -lAh $argv";
        mkcd = "mkdir $argv[1]; cd $argv[1]";
        mkshell = "nix-shell --run fish ~/Source/dotfiles/shells/$argv[1].nix";
        p = "nix-shell -p --run fish $argv";
        pw = "cd ~/Documents/pw24L";
        fr = "df -h && free -h";
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

    git = {
      enable = true;
      userName = "Piotr Fila";
      userEmail = "piotr.fila.stud@pw.edu.pl";
      extraConfig = {
        commit.gpgsign = true;
        init.defaultBranch = "main";
      };
    };

    gpg.enable = true;

    home-manager.enable = true;

    librewolf = {
      enable = true;
      # Enable WebGL, cookies and history
      settings = {
        "webgl.disabled" = false;
        # "security.OCSP.require" = false;
        "middlemouse.paste" = false;
        "general.autoScroll" = true;
        "privacy.clearOnShutdown.history" = false;
        "privacy.resistFingerprinting.letterboxing" = true;
        "network.cookie.lifetimePolicy" = 0;
      };
    };

    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-backgroundremoval
        obs-pipewire-audio-capture
      ];
    };
  };

  # services.gnome-keyring = {
  #   enable = true;
  #   components = [ "ssh" ];
  # };

  dconf.enable = true;
  dconf.settings =
    if osConfig.networking.hostName == "homelab"
    then {
      "org/gnome/desktop/interface".color-scheme = "prefer-dark";

      "org/virt-manager/virt-manager/connections" = {
        autoconnect = ["qemu:///system"];
        uris = ["qemu:///system"];
      };
    }
    else {
      "org/gnome/desktop/interface".color-scheme = "prefer-dark";
    };

  home.stateVersion = "23.11";

  xdg.desktopEntries = {
    ltspice = let
      docs = "/home/kaliko/Documents/LTspiceXVII";
      ltspice_path = "/home/kaliko/.local/share/wine/drive_c/users/kaliko/AppData/Local/Programs/ADI/LTspice/";
    in {
      name = "LTspice";
      exec = "wine ${ltspice_path}LTspice.exe -ini ${docs}/keybinds.ini";
      terminal = false;
      icon = "${docs}/icon.jpg";
      categories = ["Application"];
    };
  };
}
