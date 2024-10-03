{ inputs, pkgs, ... }:

{
  home.packages = with pkgs; [
    feh
    ffmpeg
    rar
    rarcrack
    unzip
    zip
  ];
}