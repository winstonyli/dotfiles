{
  # Enable Cloudflare WARP
  # services.cloudflare-warp = {
  #   enable = true;
  #   certificate = ./Cloudflare_CA.crt;
  # };

  # Detect location
  services.geoclue2.enable = true;

  # Automount removable media
  services.udisks2 = {
    enable = true;
    mountOnMedia = true;
  };
}
