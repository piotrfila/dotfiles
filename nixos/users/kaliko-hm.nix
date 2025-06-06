{
  config,
  lib,
  osConfig,
  pkgs,
  ...
}: let
  util = import ../util.nix;
in {
  imports =
    [
      ../homemanager/git.nix
      ../various/python-history.nix
    ]
    ++ (
      if osConfig.programs.fish.enable
      then [../homemanager/fish.nix]
      else []
    )
    ++ (
      if osConfig.programs.hyprland.enable
      then [
        ../homemanager/alacritty.nix
        ../homemanager/calibre.nix
        # ../homemanager/cura.nix
        ../homemanager/discord.nix
        ../homemanager/gimp.nix
        ../homemanager/kicad.nix
        ../homemanager/kitty.nix
        ../homemanager/libreoffice.nix
        ../homemanager/librewolf.nix
        ../homemanager/ltspice.nix
        ../homemanager/obs-studio.nix
        # ../homemanager/okteta.nix
        # ../homemanager/orca-slicer.nix
        # ../homemanager/prism-launcher.nix
        ../homemanager/ristretto.nix
        ../homemanager/spotify.nix
        ../homemanager/ungoogled-chromium.nix
        ../homemanager/vscodium.nix
        ../gui/dunst.nix
        ../gui/hyprland.nix
        ../gui/hyprpaper.nix
        ../gui/themes.nix
        ../gui/waybar.nix
        ../gui/wofi.nix
      ]
      else []
    )
    ++ (
      if osConfig.programs.obs-studio.enableVirtualCamera
      then [../homemanager/obs-studio.nix]
      else []
    )
    ++ (
      if osConfig.programs.thunar.enable
      then [../homemanager/thunar.nix]
      else []
    )
    ++ (
      if osConfig.hardware.rtl-sdr.enable
      then [../homemanager/sdr.nix]
      else []
    );
  home.file = util.persist {
    inherit config;
    symlinks =
      [
        ".config/Mullvad VPN"
        ".config/qalculate"
        ".config/Raspberry Pi"
        ".local/share/cargo"
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
        then [".config/batt-cap"]
        else []
      );
  };

  home.packages = with pkgs;
    [
      libnotify
      pavucontrol
      wl-clipboard

      # gui
      libreoffice
      localsend
      mission-center
      mpv
      mullvad-vpn
      obsidian
      (python3Full.withPackages (ps:
        with ps; [
          pyserial
        ]))
      transmission_4-qt
      qalculate-qt

      alejandra
      dnsutils
      fastfetch
      file
      jq
      nano
      screen
      unzip
      wget
      zip
    ]
    ++ (
      if osConfig.networking.hostName == "um425"
      then let
        unstable = import <nixos-unstable> {config = {allowUnfree = true;};};
      in [
        # go to factorio.com/profile for the token
        # file homemanager/factorio-credentials.nix should look like this:
        # {
        #   username = "your_username";
        #   token = "0123456789abcdefgijklmnopqrstu";
        # }
        # (factorio.override (import ./factorio-credentials.nix))
        gimp

        ddcutil
        ddcui

        # logisim-evolution
        # gnome2.GConf
        # gtkwave
        # iverilog
        # verible
        # verilator

        unstable.zig
        unstable.zls
      ]
      else []
    );

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = ["FiraCode Nerd Font Mono"];
      serif = ["Noto Serif" "Garamond"];
      sansSerif = ["Noto Sans"];
    };
  };

  manual.manpages.enable = false;

  programs = {
    gpg.enable = true;
    home-manager.enable = true;
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
  xdg.mimeApps.enable = true;
}
