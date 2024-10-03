{ inputs, pkgs, ... }:

{
  imports = [
    ../shared
    ./bar.nix
    ./hypr.nix
  ];

  home.stateVersion = "24.05";
}
