{ inputs, pkgs, ... }:

{
  networking = {
    networkmanager.enable = true;

    firewall.allowedTCPPorts = [ 25565 ];
    firewall.allowedUDPPorts = [ 25565 ];
  };
}
