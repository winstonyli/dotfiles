{ inputs, pkgs, ... }:

{
  imports = [
    ./apps.nix
    ./bar.nix
    ./dev.nix
    ./hypr.nix
    ./style.nix
  ];

  home.username = "wli";
  home.homeDirectory = "/home/wli";
  home.stateVersion = "23.11";

  programs.home-manager.enable = true;

  # Remove when this becomes the default.
  systemd.user.startServices = "sd-switch";

  xdg.configFile."nixpkgs/config.nix".text = ''
    { allowUnfree = true; }
  '';
}
