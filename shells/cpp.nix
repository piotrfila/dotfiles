{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  buildInputs = with pkgs; [
    # build requirements
    clang
    cmake
    flip-link
    gnumake

    # missing libraries
    fontconfig
    # libGL
    # openssl
    pkg-config
    # pipewire.dev
    # vulkan-headers
    # vulkan-loader
    # vulkan-tools
    
    # GTK
    # atkmm
    # glib
    # gdk-pixbuf
    # pango
    # gtk3
    # gtk-layer-shell
    # libdbusmenu-gtk3
  ];
  shellHook = ''
    export OPENSSL_DIR="${pkgs.openssl.dev}"
    export OPENSSL_LIB_DIR="${pkgs.openssl.out}/lib"
    export LIBCLANG_PATH="${pkgs.libclang.lib}/lib";
    export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/run/opengl-driver/lib:/run/opengl-driver-32/lib:${
      with pkgs;
        lib.makeLibraryPath [
          # libGL
          # vulkan-loader

          # xorg.libX11
          # xorg.libXi
          # xorg.libXcursor
          # xorg.libXrandr

          # glib.out
        ]
    }"
  '';
}
