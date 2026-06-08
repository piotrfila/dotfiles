{
  config,
  lib,
  osConfig,
  pkgs,
  ...
}: let
  desktopEnvironment = "Hyprland";
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
      if desktopEnvironment == "Hyprland"
      then [
        ./gui
        ./gui/apps/alacritty.nix
        # ./gui/apps/calibre.nix
        # ./gui/apps/cura.nix
        ./gui/apps/darktable.nix
        ./gui/apps/discord.nix
        ./gui/apps/freecad.nix
        ./gui/apps/gimp.nix
        ./gui/apps/keepassxc.nix
        ./gui/apps/kicad.nix
        ./gui/apps/kitty.nix
        ./gui/apps/libreoffice.nix
        ./gui/apps/librewolf.nix
        ./gui/apps/localsend.nix
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
        ./gui/apps/transmission.nix
        ./gui/apps/ungoogled-chromium.nix
        ./gui/apps/vscodium.nix
        ./lang/octave.nix
        ./lang/verilog.nix
        # ./winboat.nix
      ]
      else []
    );

  dconf = {
    enable = true;
    settings =
      {"org/gnome/desktop/interface".color-scheme = "prefer-dark";}
      // (
        if osConfig.networking.hostName == "homelab"
        then {
          "org/virt-manager/virt-manager/connections" = {
            autoconnect = ["qemu:///system"];
            uris = ["qemu:///system"];
          };
        }
        else {}
      );
  };

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = ["FiraCode Nerd Font Mono"];
      serif = ["Noto Serif" "Garamond"];
      sansSerif = ["Noto Sans"];
    };
  };

  home = {
    packages = with pkgs; [
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
    ];
    persistence = util.persist {
      inherit config;
      directories = [
        ".cache"
        ".gnupg"
        ".local/bin"
        ".ssh"
        "Source"
      ];
      files =
        [
          ".local/state/bashhst"
          ".local/state/lesshst"
        ]
        ++ (
          if osConfig.networking.hostName == "um425"
          then [".config/batt-cap"]
          else []
        );
    };
    sessionPath = ["${config.home.homeDirectory}/.local/bin"];
    sessionVariables.HISTFILE = "${config.xdg.stateHome}/bashhst";
    stateVersion = "23.11";
  };

  manual.manpages.enable = false;

  programs = {
    gpg = {
      enable = true;
      homedir = "${config.xdg.dataHome}/gnupg";
    };
    home-manager.enable = true;
  };

  xdg.enable = true;
}
