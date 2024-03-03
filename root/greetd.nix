{ inputs, pkgs, ... }:

{
  services.greetd = {
    enable = true;
    settings.default_session.command =
      "${pkgs.greetd.tuigreet}/bin/tuigreet --cmd 'Hyprland > /dev/null' --time --asterisks";
  };

  environment.etc."greetd/environments".text = ''
    Hyprland > /dev/null
    zsh
  '';
}
