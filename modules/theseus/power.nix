##############################
# BATTERY LIFE OPTIMIZATIONS #
##############################
{ inputs, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    powertop # for CLI usage
  ];

  # Stock NixOS power management tool
  powerManagement.enable = true;

  # Power analysis and autotuning
  powerManagement.powertop.enable = true;

  # Automatic CPU frequency tuning
  services.auto-cpufreq.enable = true;
  services.auto-cpufreq.settings = {
    battery = {
      governor = "powersave";
      turbo = "never";
    };
    charger = {
      governor = "performance";
      turbo = "auto";
    };
  };
}
