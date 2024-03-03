{ inputs, pkgs, ... }:

{
  gtk = {
    enable = true;

    iconTheme.name = "Papirus-Dark";
    iconTheme.package = pkgs.papirus-icon-theme;
  };
}
