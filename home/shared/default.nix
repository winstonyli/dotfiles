{ inputs, pkgs, ... }:

{
  imports = [
    ./apps.nix
    ./dev.nix
    ./style.nix
  ];

  home.username = "wli";
  home.homeDirectory = "/home/wli";

  programs.home-manager.enable = true;

  # Remove when this becomes the default.
  systemd.user.startServices = "sd-switch";

  xdg.configFile."nixpkgs/config.nix".text = ''
    { allowUnfree = true; }
  '';
}
