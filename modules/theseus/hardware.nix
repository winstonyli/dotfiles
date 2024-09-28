{ inputs, pkgs, ... }:

{
  # hardware.framework.amd-7040.preventWakeOnAC = true;

  # Tool to update Framework firmware
  services.fwupd = {
    enable = true;

    # Need fwupd 1.9.7 to downgrade fingerprint sensor firmware
    package = (import
      (builtins.fetchTarball {
        url = "https://github.com/NixOS/nixpkgs/archive/bb2009ca185d97813e75736c2b8d1d8bb81bde05.tar.gz";
        sha256 = "sha256:003qcrsq5g5lggfrpq31gcvj82lb065xvr7bpfa8ddsw8x4dnysk";
      })
      {
        inherit (pkgs) system;
      }).fwupd;
  };

  hardware.opengl = {
    enable = true; # RADV drivers
    extraPackages = with pkgs; [
      rocmPackages.clr.icd
      libvdpau-va-gl
      vaapiVdpau
    ];
  };
  hardware.amdgpu.opencl = true;

  zramSwap.enable = true;

  
  ##############################
  # hardware-configuration.nix #
  ##############################
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "thunderbolt" "usbhid" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/db08ec8a-1fc0-43d4-b3c1-280a0a07c7e6";
      fsType = "btrfs";
      options = [ "subvol=@" "noatime" ];
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/69FE-38A4";
      fsType = "vfat";
      options = [ "noatime" ];
    };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.docker0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp1s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

}
