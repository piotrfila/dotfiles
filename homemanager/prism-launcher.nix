{
  config,
  pkgs,
  ...
}: let
  util = import ../util.nix;
in {
  home = {
    packages = with pkgs; [(prismlauncher.override {jdks = [jdk8 jdk17 jdk21];})];
    persistence = util.persist {
      inherit config;
      directories = [".local/share/PrismLauncher"];
    };
  };
  wayland.windowManager.hyprland.settings.windowrule = ["tile, class:^(Minecraft)"];
}
