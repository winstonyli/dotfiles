{ inputs, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    wl-clipboard
    wlr-randr
  ];

  # Hyprland flake
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.default;
  };

  # XDG portals
  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };

  # File manager
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
    ];
  };

  # Sound with pipewire
  sound.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  # Brightness control
  hardware.brillo.enable = true;

  # Printing with CUPS
  services.printing.enable = true;

  # Privilege management
  security.polkit.enable = true;
}
