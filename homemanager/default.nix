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
      ./python-history.nix
      ./zig.nix
    ]
    ++ (
      if osConfig.programs.fish.enable
      then [../homemanager/fish.nix]
      else []
    )
    ++ (
      if osConfig.programs.hyprland.enable
      then
        [
          ./alacritty.nix
          ./calibre.nix
          # ./cura.nix
          ./discord.nix
          ./dunst.nix
          ./gimp.nix
          ./hyprland.nix
          ./hyprpaper.nix
          ./kicad.nix
          ./kitty.nix
          ./libreoffice.nix
          ./librewolf.nix
          ./ltspice.nix
          ./mission-center.nix
          ./mpv.nix
          ./obs-studio.nix
          # ./okteta.nix
          # ./orca-slicer.nix
          # ./prism-launcher.nix
          ./qalculate.nix
          ./ristretto.nix
          ./spotify.nix
          ./themes.nix
          ./ungoogled-chromium.nix
          # ./verilog.nix
          ./vscodium.nix
          ./waybar.nix
          ./wofi.nix
        ]
        ++ (
          let
            im = osConfig.i18n.inputMethod;
          in
            if im.enable && im.type == "fcitx"
            then [../homemanager/fcitx.nix]
            else []
        )
        ++ (
          if osConfig.programs.obs-studio.enableVirtualCamera
          then [../homemanager/obs-studio.nix]
          else []
        )
        ++ (
          if osConfig.services.mullvad-vpn.enable
          then [../homemanager/mullvad-vpn.nix]
          else []
        )
        ++ (
          if osConfig.hardware.rtl-sdr.enable
          then [../homemanager/rtl-sdr.nix]
          else []
        )
        ++ (
          if osConfig.programs.steam.enable
          then [../homemanager/rtl-sdr.nix]
          else []
        )
        ++ (
          if osConfig.programs.thunar.enable
          then [../homemanager/thunar.nix]
          else []
        )
      else []
    );
  home.file = util.persist {
    inherit config;
    symlinks =
      [
        ".config/Raspberry Pi"
        ".local/share/cargo"
        ".local/share/rustup"
        ".local/share/wine"
        ".local/state/wireplumber"
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
      alejandra
      ddcutil
      ddcui
      dnsutils
      fastfetch
      ffmpeg
      file
      jq
      nano
      (python3Full.withPackages (ps:
        with ps; [
          pyserial
        ]))
      screen
      unzip
      wget
      zip
    ]
    ++ (
      if osConfig.programs.hyprland.enable
      then [
        localsend
        obsidian
        transmission_4-qt
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
