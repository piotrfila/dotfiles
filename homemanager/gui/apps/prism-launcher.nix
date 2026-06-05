{
  config,
  pkgs,
  ...
}: let
  util = import ../../../util.nix;
in {
  home = {
    packages = with pkgs; [(prismlauncher.override {jdks = [jdk8 jdk17 jdk21 jdk25];})];
    persistence = util.persist {
      inherit config;
      directories = [".local/share/PrismLauncher"];
    };
  };
  wayland.windowManager.hyprland.settings.windowrule = [
    {
      name = "minecraft";
      "match:class" = "^(Minecraft)";
      tile = true;
    }
    {
      name = "prismlauncher_wait";
      "match:title" = "^(Please wait).*(Prism Launcher)";
      float = true;
    }
  ];
}
