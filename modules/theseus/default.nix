{
  imports = [
    ./boot.nix
    ./greetd.nix
    ./hardware.nix
    ./networking.nix
    ./power.nix
  ];

  networking.hostName = "wli-theseus";
  system.stateVersion = "23.11";
}
