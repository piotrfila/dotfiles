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
      ./git.nix
      ./lang/python.nix
      ./lang/zig.nix
    ]
    ++ (
      if osConfig.programs.fish.enable
      then [./fish.nix]
      else []
    )
    ++ (
      if osConfig.programs.hyprland.enable
      then [
        ./gui
        ./gui/apps/alacritty.nix
        ./gui/apps/calibre.nix
        # ./gui/apps/cura.nix
        ./gui/apps/darktable.nix
        ./gui/apps/discord.nix
        ./gui/apps/gimp.nix
        ./gui/apps/kicad.nix
        ./gui/apps/kitty.nix
        ./gui/apps/libreoffice.nix
        ./gui/apps/librewolf.nix
        ./gui/apps/ltspice.nix
        ./gui/apps/mindustry.nix
        ./gui/apps/mission-center.nix
        ./gui/apps/mpv.nix
        ./gui/apps/obs-studio.nix
        # ./gui/apps/okteta.nix
        ./gui/apps/orca-slicer.nix
        ./gui/apps/prism-launcher.nix
        ./gui/apps/qalculate.nix
        ./gui/apps/ristretto.nix
        ./gui/apps/signal.nix
        ./gui/apps/spotify.nix
        ./gui/apps/starsector.nix
        ./gui/apps/ungoogled-chromium.nix
        ./gui/apps/vscodium.nix
        ./lang/octave.nix
        ./lang/verilog.nix
        # ./winboat.nix
      ]
      else []
    );
  home.persistence = util.persist {
    inherit config;
    directories = [
      ".cache"
      ".ciel"
      ".config/xfce4/xfconf/xfce-perchannel-xml"
      ".factorio"
      ".gnupg"
      ".local/bin"
      ".local/share/wine"
      ".local/state/wireplumber"
      ".pki"
      ".ssh"
      "Documents"
      "Downloads"
      "Pictures"
      "Source"
    ];
    files =
      [
        ".local/share/recently-used.xbel"
        ".local/state/bashhst"
        ".local/state/lesshst"
      ]
      ++ (
        if osConfig.networking.hostName == "um425"
        then [".config/batt-cap"]
        else []
      );
  };

  home.packages = with pkgs;
    [
      alejandra
      codespell
      ddcutil
      ddcui
      dnsutils
      fastfetch
      ffmpeg
      file
      jq
      nano
      qemu
      screen
      tio
      unzip
      usbutils
      wget
      zip
    ]
    ++ (
      if osConfig.programs.hyprland.enable
      then [
        localsend
        transmission_4-qt
      ]
      else []
    )
    ++ (
      if osConfig.hardware.rtl-sdr.enable
      then [gnuradio gqrx]
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
