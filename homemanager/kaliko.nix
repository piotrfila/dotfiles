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
  ];
  home.file = builtins.listToAttrs (
    builtins.map (x: {
      name = x;
      value = {
        source = config.lib.file.mkOutOfStoreSymlink "/nix/persist${config.home.homeDirectory}/${x}";
      };
    }) ([
        ".config/chromium"
        ".config/hypr/extra.conf"
        ".config/Mullvad VPN"
        ".config/qalculate"
        ".config/Raspberry Pi"
        ".config/spotify"
        ".config/xfce4"
        ".local/share/cargo"
        ".local/share/fish/generated-completions"
        ".local/share/fish/fish_history"
        ".local/share/fish/fonts"
        ".local/share/rustup"
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
      spotify
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
        discord
        # go to factorio.com/profile for the token
        # file homemanager/factorio-credentials.nix should look like this:
        # {
        #   username = "your_username";
        #   token = "0123456789abcdefgijklmnopqrstu";
        # }
        (factorio.override (import ./factorio-credentials.nix))
        gimp
        gnuradio
        gqrx
        kicad
        logisim-evolution
        (prismlauncher.override {jdks = [jdk8 jdk17 jdk21];})
        verilator
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

  gtk = let
    gtk-settings = {
      gtk-error-bell = false;
      gtk-application-prefer-dark-theme = 1;
    };
  in {
    enable = true;
    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
    gtk2.extraConfig = ''
      gtk-error-bell=0
      gtk-application-prefer-dark-theme=1
    '';

    gtk3.bookmarks = let
      dirs = config.xdg.userDirs;
      home = config.home.homeDirectory;
    in [
      "file://${dirs.documents}"
      "file://${dirs.download}"
      "file://${dirs.pictures}"
      "file://${home}/Source"
      "file://${dirs.documents}/pw24Z"
      "file://${dirs.documents}/kicad"
      "file://${dirs.documents}/datasheets"
      "file://${dirs.documents}/3D_Models"
      "file:///nix/persist${home}"
    ];
    gtk3.extraConfig = gtk-settings;
    gtk4.extraConfig = gtk-settings;

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
      #   name = "Arc";
      #   package = pkgs.arc-icon-theme;
    };

    theme = {
      name = "Arc-Dark";
      package = pkgs.arc-theme;
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 12;
  };

  qt = {
    enable = true;
    platformTheme.name = "adwaita";
    style = {
      name = "adwaita-dark";
      package = pkgs.adwaita-qt;
    };
  };

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
}
