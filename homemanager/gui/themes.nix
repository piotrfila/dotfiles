{
  config,
  pkgs,
  ...
}: {
  gtk = let
    gtk-settings = {
      gtk-error-bell = false;
      gtk-application-prefer-dark-theme = 1;
      gtk-im-module = "fcitx";
    };
    theme = {
      name = "Arc-Dark";
      package = pkgs.arc-theme;
    };
  in {
    enable = true;
    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
    gtk2.extraConfig = ''
      gtk-error-bell=0
      gtk-application-prefer-dark-theme=1
      gtk-im-module="fcitx"
    '';

    gtk3.bookmarks = let
      dirs = config.xdg.userDirs;
      home = config.home.homeDirectory;
    in [
      "file://${dirs.documents}"
      "file://${dirs.download}"
      "file://${dirs.pictures}"
      "file://${home}/Source"
      "file://${dirs.documents}/kicad"
      "file://${dirs.documents}/datasheets"
      "file://${dirs.documents}/3D_Models"
      "file:///nix/persist${home}"
    ];
    gtk3.extraConfig = gtk-settings;

    gtk4.theme = theme;
    gtk4.extraConfig = gtk-settings;

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    theme = theme;
  };

  home = {
    pointerCursor = {
      gtk.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 12;
    };
    sessionVariables.GTK2_RC_FILES = "${config.xdg.configHome}/gtk-2.0/gtkrc";
  };

  qt = {
    enable = true;
    platformTheme.name = "adwaita";
    style = {
      name = "adwaita-dark";
      package = pkgs.adwaita-qt;
    };
  };
}
