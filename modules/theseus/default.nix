{
  imports = [
    ./boot.nix
    ./desktop.nix
    ./env.nix
    ./fcitx.nix
    ./games.nix
    ./greetd.nix
    ./hardware.nix
    ./networking.nix
    ./power.nix
    ./services.nix
    ./style.nix
  ];

  networking.hostName = "wli-theseus";
  system.stateVersion = "23.11";
}
