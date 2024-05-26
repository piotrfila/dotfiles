{ config, lib, osConfig, pkgs, ... }: {
  imports = [
    ../homemanager/alacritty.nix
    ../homemanager/dunst.nix
    ../homemanager/hyprland.nix
    ../homemanager/hyprpaper.nix
    ../homemanager/kitty.nix
    ../homemanager/mime.nix
    ../homemanager/python-history.nix
    ../homemanager/thunar-actions.nix
    ../homemanager/waybar.nix
    ../homemanager/wofi.nix
  ];
  home.file = if osConfig.networking.hostName == "um425"
  then (builtins.listToAttrs (
    builtins.map ( x: {
      name = x;
      value = {
        source = config.lib.file.mkOutOfStoreSymlink "/nix/persist/home/kaliko/${x}";
      };
    }) [
      ".cache/fontconfig"
      ".cache/grc_gnuradio"
      ".cache/mesa_shader_cache"
      ".cache/mozilla"
      ".cache/spotify"
      ".cache/thumbnails"
      ".cache/typescript"
      ".cache/vscode-cpptools"
      ".cache/wine"
      ".cache/winetricks"
      ".cache/zig"
      ".cache/zls"
      ".cache/.bluetoothctl_history"
      ".config/chromium"
      ".config/discord"
      ".config/hypr/extra.conf"
      ".config/Mullvad VPN"
      ".config/qalculate"
      ".config/spotify"
      ".config/VSCodium"
      ".config/xfce4"
      ".config/batt-cap"
      ".factorio"
      ".local/share/cargo"
      ".local/share/fish/generated_completions"
      ".local/share/fish/fish_history"
      ".local/share/fish/fonts"
      ".local/share/rustup"
      ".local/share/Steam"
      ".local/state/wireplumber"
      ".local/state/python_history"
      ".mozilla"
      ".pki"
      ".ssh"
      ".vscode-oss"
      "Documents"
      "Downloads"
      "Pictures"
      "Source"
    ]
  )) else { };

  home.packages = with pkgs; [
    libnotify
    pavucontrol
    # swayosd
    wl-clipboard

    # gui
    # arduino
    # audacity
    discord
    firefox
    # foliate
    gimp
    # gnuradio
    # gparted
    # gqrx
    # kicad-small
    libreoffice
    # logisim-evolution
    mission-center
    mpv
    mullvad-vpn
    # obs-studio
    # obsidian
    # okteta
    # prismlauncher
    spotify
    qalculate-qt
    ungoogled-chromium
    # verilator
    # vlc
    vscodium
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
  ];

  manual.manpages.enable = false;

  programs = {
    fish = {
      enable = true;

      functions = {
        # la = "ls -lAh $argv";
        mkcd = "mkdir $argv[1]; cd $argv[1]";
        mkshell = "nix-shell --run fish ~/Source/dotfiles/shells/$argv[1].nix";
        p = "nix-shell -p --run fish $argv";
        pw = "cd ~/Documents/pw24L";
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

      plugins = [ ];
    };
    bash.enable = false;
    home-manager.enable = true;
  };

  services.gnome-keyring = {
    enable = true;
    components = [ "ssh" ];
  };

  gtk = let
    gtk-settings = {
      gtk-error-bell = false;
      gtk-application-prefer-dark-theme = 1;
    };
  in {
    enable = true;
    font = {
      name = "Sans"; # "MesloLGS Nerd Font";
      size = 11;
    };

    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
    gtk2.extraConfig = ''
      gtk-error-bell=0
      gtk-application-prefer-dark-theme=1
    '';

    gtk3.bookmarks = [
      "file:///home/kaliko/Documents"
      "file:///home/kaliko/Downloads"
      "file:///home/kaliko/Pictures"
      "file:///home/kaliko/Source"
      "file:///home/kaliko/Documents/pw24L"
      "file:///nix/persist/home/kaliko"
    ];
    gtk3.extraConfig = gtk-settings;

    gtk4.extraConfig = gtk-settings;
    
    iconTheme = {
      name = "Arc";
      package = pkgs.arc-icon-theme;
    };

    # iconTheme = {
    #   name = "Papirus-Dark";
    #   package = pkgs.papirus-icon-theme;
    # };

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
  dconf.settings = if osConfig.networking.hostName == "homelab"
  then {
    "org/gnome/desktop/interface".color-scheme = "prefer-dark";

    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  } else {
    "org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };


  programs.git = {
    enable = true;
    userName = "Piotr Fila";
    userEmail = "piotr.fila.stud@pw.edu.pl";
    extraConfig.init.defaultBranch = "main";
  };
  
  home.stateVersion = "23.11";
}
