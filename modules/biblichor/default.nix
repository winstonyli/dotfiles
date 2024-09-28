{
  imports = [ 
    ./hardware.nix
  ];

  networking.hostName = "wli-biblichor";
  system.stateVersion = "24.05";

  # Misc. WSL-specific settings
  programs.nix-ld.enable = true;

  wsl = {
    enable = true;
    defaultUser = "wli";
    startMenuLaunchers = true;
  };
}
