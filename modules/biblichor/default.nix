{
  networking.hostName = "wli-biblichor";
  system.stateVersion = "24.05";

  # Misc. WSL-specific settings
  programs.nix-ld.enable = true;

  wsl = {
    enable = true;
    defaultUser = "wli";
    startMenuLaunchers = true;
  };

  networking.networkmanager.wifi.macAddress = "16:ac:60:46:a3:07";
}
