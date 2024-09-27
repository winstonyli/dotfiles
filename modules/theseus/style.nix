{ inputs, pkgs, ... }:

{
  # See https://github.com/tinted-theming/base16-schemes
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-material-dark-hard.yaml";
  stylix.image = ../../wallpaper.webp;
  stylix.polarity = "dark";

  stylix.cursor = {
    name = "Banana";
    package = pkgs.banana-cursor;
    size = 32;
  };

  stylix.fonts = {
    sansSerif.package = pkgs.roboto;
    sansSerif.name = "Roboto";

    monospace.package = pkgs.nerdfonts;
    monospace.name = "FantasqueSansM Nerd Font Mono";

    sizes.applications = 13;
    sizes.desktop = 13;
    sizes.popups = 13;
    sizes.terminal = 15;
  };

  fonts.packages = with pkgs; [
    corefonts
    google-fonts
    winePackages.fonts
  ];
}
