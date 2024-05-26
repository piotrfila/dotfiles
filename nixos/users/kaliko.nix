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
      ".mozilla"
      "Documents"
      "Downloads"
      "Pictures"
      "Source"
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
    ] ++ (if config.networking.hostName == "homelab"
    then [
      "libvirtd"
    ] else [ ]);
    hashedPasswordFile = "/nix/persist/home/kaliko/passwd";
    isNormalUser = true;
    shell = pkgs.fish;
  };
}
