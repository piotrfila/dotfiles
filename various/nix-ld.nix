{pkgs, ...}: {
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      alsa-lib
      libGL
      libice
      libsm
      libx11
      libxcursor
      libxext
      libxi
      libxinerama
      libxrandr
      libpulseaudio
      libxkbcommon
      wayland
    ];
  };
}
