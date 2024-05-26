{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    grim
    slurp
    (writeShellScriptBin "screenshot" ''
    dir="${config.xdg.userDirs.pictures}/Screenshots/$(date +%Y.%m.%d-%H:%M:%S).png"
    grim -g "$(slurp)" - | tee "$dir" | wl-copy
  '') ];
}
