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
          ./darktable.nix
          ./discord.nix
          ./dunst.nix
          ./fcitx.nix
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
          ./orca-slicer.nix
          ./prism-launcher.nix
          ./pulseview.nix
          ./qalculate.nix
          ./ristretto.nix
          ./signal.nix
          ./spotify.nix
          ./starsector.nix
          ./themes.nix
          ./ungoogled-chromium.nix
          ./verilog.nix
          ./vscodium.nix
          ./waybar.nix
          # ./winboat.nix
          ./wofi.nix
        ]
        ++ (
          if osConfig.programs.obs-studio.enableVirtualCamera
          then [./obs-studio.nix]
          else []
        )
        ++ (
          if osConfig.services.mullvad-vpn.enable
          then [./mullvad-vpn.nix]
          else []
        )
        ++ (
          if osConfig.hardware.rtl-sdr.enable
          then [./rtl-sdr.nix]
          else []
        )
        ++ (
          if osConfig.programs.steam.enable
          then [./steam.nix]
          else []
        )
        ++ (
          if osConfig.programs.thunar.enable
          then [./thunar.nix]
          else []
        )
      else []
    );
  home.persistence = util.persist {
    inherit config;
    directories = [
      ".cache"
      # ".config/Raspberry Pi"
      ".config/xfce4/xfconf/xfce-perchannel-xml"
      ".factorio"
      ".gnupg"
      ".librewolf"
      ".local/bin"
      # ".local/share/cargo"
      # ".local/share/rustup"
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
      ddcutil
      ddcui
      dnsutils
      fastfetch
      ffmpeg
      file
      jq
      nano
      (octave.withPackages (ps: [
        ps.signal
      ]))
      (python3.withPackages (ps: [
        ps.pyserial
        ps.tkinter
      ]))
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
