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
}
