{
  config,
  pkgs,
  ...
}: {
  fileSystems = builtins.listToAttrs (
    builtins.map (x: {
      name = "/home/kaliko/${x}";
      value = {
        device = "/nix/persist/home/kaliko/${x}";
        fsType = "none";
        options = ["bind"];
      };
    }) [
      ".cache"
      ".factorio"
      ".gnupg"
      ".librewolf"
      ".pki"
      ".ssh"
      ".vscode-oss"
    ]
  );

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users.kaliko.imports = [../../homemanager/kaliko.nix];
  };

  users.mutableUsers = false;
  users.users.kaliko = {
    extraGroups =
      [
        "i2c"
        "input"
        "dialout"
        "plugdev"
        "udev"
        "wheel"
      ]
      ++ (
        if config.networking.hostName == "homelab"
        then [
          "libvirtd"
        ]
        else if config.networking.hostName == "um425"
        then [
          "adbusers"
        ]
        else []
      );
    hashedPasswordFile = "/nix/persist/home/kaliko/passwd";
    isNormalUser = true;
    shell = pkgs.fish;
  };
}
