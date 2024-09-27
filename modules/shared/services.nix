{
  # Detect location
  services.geoclue2.enable = true;

  # Automount removable media
  services.udisks2 = {
    enable = true;
    mountOnMedia = true;
  };
}
