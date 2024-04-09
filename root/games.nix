########################
# GAMING OPTIMIZATIONS #
########################
{ inputs, pkgs, ... }:

{
  programs.gamemode.enable = true;

  programs.gamescope.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Firewall ports for Steam Remote Play
    dedicatedServer.openFirewall = true; # Firewall ports for Source Dedicated Server
    gamescopeSession.enable = true;
  };

  virtualisation.waydroid.enable = true;
}
