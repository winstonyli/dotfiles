###########################
# DESKTOP APPS & SERVICES #
###########################
{ inputs, pkgs, ... }:

{
  home.packages = with pkgs; [
    armcord
    aseprite
    blender
    bottles
    cinny-desktop
    gimp
    github-desktop
    grapejuice
    heroic
    hyfetch
    lutris
    mission-center
    (prismlauncher.override {
      inherit (inputs.prismlauncher.packages.${pkgs.system}) prismlauncher-unwrapped;
      jdk8 = temurin-bin-8;
      jdk17 = graalvm-ce;
      withWaylandGLFW = true;
    })
    inputs.thorium.packages.${pkgs.system}.default
    tor-browser
    vscode
    inputs.nix-gaming.packages.${pkgs.system}.wine-discord-ipc-bridge
    wine-wayland
    winetricks
    xorg.xeyes
    zoom-us
  ];

  # App launcher
  programs.fuzzel.enable = true;

  # Media preview
  programs.mpv.enable = true;

  # Keyring
  services.gnome-keyring.enable = true;

  # Night light
  services.gammastep = {
    enable = true;
    provider = "geoclue2";
  };
}
