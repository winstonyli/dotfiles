{ inputs, pkgs, ... }:

{
  imports = [
  ];

  networking.hostName = "wli-biblichor";
  system.stateVersion = "24.05";

  networking.networkmanager.wifi.macAddress = "16:ac:60:46:a3:07";

  wsl = {
    enable = true;
    defaultUser = "wli";
    startMenuLaunchers = true;
  };

  # Enable VSCode
  programs.nix-ld.enable = true;
}
