{pkgs, ...}: {
  home.packages = with pkgs; [gnuradio gqrx];
}
