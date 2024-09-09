{
  config,
  packages,
  ...
}: {
  services = {
    ollama = {
      enable = true;
      acceleration = "cuda";
    };
    # openssh.enable = true;
    xserver.videoDrivers = ["nvidia"];
  };

  systemd.services = {
    nvidia-control-devices = {
      wantedBy = ["multi-user.target"];
      serviceConfig.execStart = "${pkgs.linuxPackages.nvidia_x11.bin}/bin/nvidia-smi";
    };
  };

  # Create directories and run scripts for the containers
  system.activationScripts = {
    script.text = ''
      install -d -m 755 /home/llama/open-webui/data -o root -g root
    '';
  };

  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      #defaultNetwork.settings.dns_enabled = true;
    };

    oci-containers = {
      backend = "podman";

      containers = {
        open-webui = import ./open-webui.nix;
      };
    };
  };
}
