{ inputs, pkgs, ... }:

{
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      libsForQt5.fcitx5-qt
      fcitx5-gtk
      fcitx5-rime
      fcitx5-chinese-addons
    ];
    fcitx5.settings.inputMethod = {
      "Groups/0" = {
        Name = "Default";
        "Default Layout" = "us";
        DefaultIM = "pinyin";
      };
      "Groups/0/Items/0" = {
        Name = "keyboard-us";
        Layout = "";
      };
      "Groups/0/Items/1" = {
        Name = "pinyin";
        Layout = "";
      };
      GroupOrder."0" = "Default";
    };
  };
}
