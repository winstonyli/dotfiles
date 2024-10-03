{ inputs, pkgs, ... }:

{
  imports = [
    ../shared
    ./apps.nix
  ];

  home.stateVersion = "23.11";
}
