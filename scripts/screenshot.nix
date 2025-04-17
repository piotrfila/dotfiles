{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    grim
    slurp
    (writeShellScriptBin "screenshot" ''
      dir="${config.xdg.userDirs.pictures}/Screenshots/$(date +%Y.%m.%d-%H:%M:%S).png"
      grim -g "$(slurp -w 0 -b 00000030)" - | tee "$dir" | wl-copy
    '')
  ];
}
