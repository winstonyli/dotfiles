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
    cloudflare-warp
    feh
    ffmpeg
    gimp
    github-desktop
    grapejuice
    heroic
    hyfetch
    krabby
    lutris
    mission-center
    (prismlauncher.override {
      inherit (inputs.prismlauncher.packages.${pkgs.system}) prismlauncher-unwrapped;
      jdk8 = temurin-bin-8;
      jdk17 = graalvm-ce;
      withWaylandGLFW = true;
    })
    rar
    rarcrack
    inputs.thorium.packages.${pkgs.system}.default
    tor-browser
    unzip
    vscode
    inputs.nix-gaming.packages.${pkgs.system}.wine-discord-ipc-bridge
    wine-wayland
    winetricks
    xorg.xeyes
    zip
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

  # Default apps
  xdg.mimeApps = {
    enable = true;

    defaultApplications = {
      "text/html" = "thorium-browser.desktop";
      "x-scheme-handler/http" = "thorium-browser.desktop";
      "x-scheme-handler/https" = "thorium-browser.desktop";
      "x-scheme-handler/about" = "thorium-browser.desktop";
      "x-scheme-handler/mailto" = "thorium-browser.desktop";
      "x-scheme-handler/unknown" = "thorium-browser.desktop";
      "inode/directory" = "thunar.desktop";
    };
  };
}
