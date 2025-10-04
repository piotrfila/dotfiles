{
  config,
  pkgs,
  ...
}: let
  util = import ../util.nix;
in {
  home.file = util.persist {
    inherit config;
    symlinks = [".local/share/PrismLauncher"];
  };
  home.packages = with pkgs; [(prismlauncher.override {jdks = [jdk8 jdk17 jdk21];})];
  wayland.windowManager.hyprland.settings.windowrule = ["tile, class:^(Minecraft)"];
}
