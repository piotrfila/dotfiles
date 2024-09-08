{ config, pkgs, ... }: {
  fileSystems = (builtins.listToAttrs (
    builtins.map ( x: {
      name = "/home/kaliko/${x}";
      value = {
        device = "/nix/persist/home/kaliko/${x}";
        fsType = "none";
        options = [ "bind" ];
      };
    }) [
      ".cache"
      ".factorio"
      ".librewolf"
      ".mozilla"
      ".pki"
      ".ssh"
      ".vscode-oss"
    ]
  ));

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users.kaliko.imports = [ ../../homemanager/kaliko.nix ];
    # extraSpecialArgs = {
    #   inherit inputs;
    # };
    # modules = [
    #   hyprland.homeManagerModules.default
    # ];
  };

  users.mutableUsers = false;
  users.users.kaliko = {
    extraGroups = [
      "input"
      "dialout"
      "plugdev"
      "udev"
      "wheel"
      "adbusers"
    ] ++ (if config.networking.hostName == "homelab"
    then [
      "libvirtd"
    ] else [ ]);
    hashedPasswordFile = "/nix/persist/home/kaliko/passwd";
    isNormalUser = true;
    shell = pkgs.fish;
  };
}
