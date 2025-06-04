{
  config,
  pkgs,
  ...
}: {
  home.file = import ../util/persist.nix {
    inherit config;
    symlinks = [".local/share/PrismLauncher"];
  };
  home.packages = with pkgs; [prismlauncher.override {jdks = [jdk8 jdk17 jdk21];}];
}
