{
  config,
  lib,
  osConfig,
  pkgs,
  ...
}: let
  util = import ./util.nix;
in {
  imports =
    [
      ./apps/git.nix
      ./python-history.nix
    ]
    ++ (
      let
        inputMethod = osConfig.i18n.inputMethod;
      in
        if inputMethod.enable && inputMethod.type == "fcitx5"
        then [./gui/fcitx.nix]
        else []
    )
    ++ (
      if osConfig.programs.fish.enable
      then [./apps/fish.nix]
      else []
    )
    ++ (
      if osConfig.programs.hyprland.enable
      then [
        ./apps/alacritty.nix
        ./apps/calibre.nix
        # ./apps/cura.nix
        ./apps/discord.nix
        ./apps/gimp.nix
        ./apps/kicad.nix
        ./apps/kitty.nix
        ./apps/libreoffice.nix
        ./apps/librewolf.nix
        ./apps/ltspice.nix
        ./apps/obs-studio.nix
        # ./apps/okteta.nix
        # ./apps/orca-slicer.nix
        # ./apps/prism-launcher.nix
        ./apps/ristretto.nix
        ./apps/spotify.nix
        ./apps/ungoogled-chromium.nix
        ./apps/vscodium.nix
        ./gui/dunst.nix
        ./gui/hyprland.nix
        ./gui/hyprpaper.nix
        ./gui/waybar.nix
        ./gui/wofi.nix
        ./themes.nix
      ]
      else []
    )
    ++ (
      if osConfig.programs.obs-studio.enableVirtualCamera
      then [./apps/obs-studio.nix]
      else []
    )
    ++ (
      if osConfig.programs.thunar.enable
      then [./apps/thunar.nix]
      else []
    )
    ++ (
      if osConfig.hardware.rtl-sdr.enable
      then [./apps/sdr.nix]
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
