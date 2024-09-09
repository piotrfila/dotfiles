{lib, ...}: {
  zramSwap = {
    enable = true;
    algorithm = lib.mkDefault "zstd";
    memoryPercent = lib.mkDefault 75;
  };
}
