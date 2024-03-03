{ inputs, pkgs, ... }:

{
  users.mutableUsers = false;

  users.users.wli = {
    isNormalUser = true;
    description = "Winston Li";
    hashedPassword =
      "$6$RlXRKU3XwRr0kIfT$UjHSP6VX9yvGICl.YeyrzK2Ds71gs3vBipEQZgAY9vKykaPrfecRekdigWUAMN.0RC5SqJoA.K1fJ5pcTcPDT1";
    extraGroups = [ "networkmanager" "wheel" "video" ];
    shell = pkgs.zsh;
  };

  # No password for sudo
  security.sudo.wheelNeedsPassword = false;
}
