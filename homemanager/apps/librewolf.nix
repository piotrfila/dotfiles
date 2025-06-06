{pkgs, ...}: {
  programs.librewolf = {
    enable = true;
    settings = {
      "webgl.disabled" = false;
      # "security.OCSP.require" = false;
      "middlemouse.paste" = false;
      "general.autoScroll" = true;
      "privacy.clearOnShutdown.history" = false;
      "privacy.resistFingerprinting.letterboxing" = true;
      "network.cookie.lifetimePolicy" = 0;
    };
  };
  xdg.mimeApps.defaultApplications = import ../util/fill-with.nix {
    value = ["librewolf.desktop"];
    keys = [
      "application/pdf"
      "image/webp"
      "text/html"
      "x-scheme-handler/http"
      "x-scheme-handler/https"
      "x-scheme-handler/about"
      "x-scheme-handler/unknown"
    ];
  };
}
