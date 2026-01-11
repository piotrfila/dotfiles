{
  config,
  pkgs,
  ...
}: let
  impermanence = builtins.fetchTarball "https://github.com/nix-community/impermanence/archive/69ca099e5318bd9c12bc67211cbb23c4c3643b2b.tar.gz";
in {
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users.kaliko.imports = [
      "${impermanence}/home-manager.nix"
      ../homemanager
    ];
  };

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

  # users.extraGroups.docker.members = let
  #   docker = config.virtualisation.docker;
  # in
  #   if (docker.enable || docker.rootless.enable)
  #   then ["kaliko"]
  #   else [];
}
