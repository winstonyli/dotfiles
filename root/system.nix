{ inputs, pkgs, ... }:

{
  ##############
  # FILESYSTEM #
  ##############
  fileSystems."/".options = [ "subvol=@" "noatime" ];
  fileSystems."/boot".options = [ "noatime" ];

  ########
  # BOOT #
  ########
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ "amdgpu.sg_display=0" ];
    blacklistedKernelModules = [ "bluetooth" "btusb" ];

    # Secure boot
    bootspec.enable = true;

    loader.systemd-boot.enable = pkgs.lib.mkForce false;
    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };

    loader.efi.canTouchEfiVariables = true;

    tmp.useTmpfs = true;
  };

  networking = {
    hostName = "wli-framework";

    networkmanager.enable = true;

    firewall.allowedTCPPorts = [ 25565 ];
    firewall.allowedUDPPorts = [ 25565 ];
  };

  ######################
  # FRAMEWORK/HARDWARE #
  ######################
  hardware.framework.amd-7040.preventWakeOnAC = true;

  services.fwupd.enable = true; # Tool to update Framework firmware
  # we need fwupd 1.9.7 to downgrade the fingerprint sensor firmware
  services.fwupd.package = (import
    (builtins.fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/bb2009ca185d97813e75736c2b8d1d8bb81bde05.tar.gz";
      sha256 = "sha256:003qcrsq5g5lggfrpq31gcvj82lb065xvr7bpfa8ddsw8x4dnysk";
    })
    {
      inherit (pkgs) system;
    }).fwupd;

  hardware.opengl.enable = true; # RADV drivers
  hardware.opengl.extraPackages = with pkgs; [
    libva
    vaapiVdpau
    libvdpau-va-gl
  ];
  hardware.opengl.extraPackages32 = with pkgs; [
    vaapiVdpau
    libvdpau-va-gl
  ];
  hardware.amdgpu.opencl = true;

  ##########
  # LOCALE #
  ##########
  time.timeZone = "America/Los_Angeles";

  i18n = let locale = "en_US.UTF-8"; in {
    defaultLocale = locale;
    extraLocaleSettings = {
      LC_ADDRESS = locale;
      LC_IDENTIFICATION = locale;
      LC_MEASUREMENT = locale;
      LC_MONETARY = locale;
      LC_NAME = locale;
      LC_NUMERIC = locale;
      LC_PAPER = locale;
      LC_TELEPHONE = locale;
      LC_TIME = locale;
    };
  };

  #######
  # ENV #
  #######
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  ########
  # MISC #
  ########
  zramSwap.enable = true;

  # Detect location
  services.geoclue2.enable = true;

  # Automount removable media
  services.udisks2 = {
    enable = true;
    mountOnMedia = true;
  };
}
