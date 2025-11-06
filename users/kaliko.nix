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
    users.kaliko.imports = [../homemanager];
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

  users.extraGroups.docker.members = let
    docker = config.virtualisation.docker;
  in
    if (docker.enable || docker.rootless.enable)
    then ["kaliko"]
    else [];
}
