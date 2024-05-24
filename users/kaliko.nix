{ config, pkgs, ... }: {
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users.kaliko.imports = [ ./kaliko-hm.nix ];
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
    ];
    hashedPasswordFile = "/nix/persist/home/kaliko/passwd";
    isNormalUser = true;
    shell = pkgs.fish;
  };
}
