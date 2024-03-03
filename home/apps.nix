###########################
# DESKTOP APPS & SERVICES #
###########################
{ inputs, pkgs, ... }:

{
  home.packages = with pkgs; [
    armcord
    blender
    cinny-desktop
    darling
    darling-dmg
    epiphany
    ffmpeg
    github-desktop
    heroic
    hyfetch
    krabby
    lutris
    # (microsoft-edge-dev.override { commandLineArgs = "--enable-wayland-ime --gtk-version=4 --enable-features=VaapiVideoDecoder,VaapiVideoEncoder --disable-features=UseChromeOSDirectVideoDecoder --use-gl=egl"; })
    mission-center
    (inputs.prismlauncher.packages.${pkgs.system}.default.override {
      jdk17 = graalvm-ce;
    })
    temurin-bin-8
    inputs.thorium.packages.${pkgs.system}.default
    tor-browser
    vscode
    # inputs.nix-gaming.packages.${pkgs.system}.wine-discord-ipc-bridge
    # wine-wayland
    # winetricks
    xorg.xeyes
  ];

  # programs.firefox = {
  #   enable = true;
  #   package = pkgs.firefox-devedition;

  #   profiles.dev-edition-default = {
  #     userChrome = ''
  #       #TabsToolbar, #sidebar-header {
  #         visibility: collapse
  #       }
  #     '';
  #   };
  # };

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
    };
  };
}
