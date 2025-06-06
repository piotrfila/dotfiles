{pkgs, ...}: {
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

      containers.open-webui = {
        image = "ghcr.io/open-webui/open-webui:main";
        environment = {
          "TZ" = "Europe/Warsaw";
          "OLLAMA_API_BASE_URL" = "http://127.0.0.1:11434/api";
          "OLLAMA_BASE_URL" = "http://127.0.0.1:11434";
        };
        volumes = [
          "/home/llama/open-webui/data:/app/backend/data"
        ];
        ports = [
          "127.0.0.1:3000:8080" # Ensures we listen only on localhost
        ];
        extraOptions = [
          # "--pull=newer" # Pull if the image on the registry is newer
          "--name=open-webui"
          "--hostname=open-webui"
          "--network=host"
          "--add-host=host.containers.internal:host-gateway"
        ];
      };
    };
  };
}
