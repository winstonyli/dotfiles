{ inputs, pkgs, ... }:

{
  nixpkgs.overlays = [ inputs.rust-overlay.overlays.default ];

  environment.systemPackages = with pkgs; [
    # general
    curl
    git
    vim
    wget
  ];

  ###########
  # Z SHELL #
  ###########
  programs.zsh.enable = true;
  environment.pathsToLink = [ "/share/zsh" ];
  programs.starship.enable = true;

  ########
  # MISC #
  ########
  services.gnome.gnome-keyring.enable = true;
}
