{ config, inputs, pkgs, ... }:

{
  services.mako.enable = true;

  programs.waybar = {
    enable = true;

    settings = [{
      position = "top";
      layer = "top";
      height = 32;
      spacing = 12;

      modules-left = [
        "hyprland/workspaces"
      ];

      modules-center = [
        "hyprland/window"
      ];

      modules-right = [
        "network"
        "pulseaudio"
        "backlight"
        "battery"
        "clock"
        "tray"
      ];

      backlight = {
        format = "{icon}   {percent:0>3}";
        format-icons = [ "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" ];
        states = {
          medium = 15;
          high = 30;
        };
      };

      battery = {
        format = "{icon}   {capacity:0>2}";
        format-icons = [ "󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
        format-charging = "󰂄 {capacity:0>2}";
        format-plugged = "󰚥 {capacity:0>2}";
        states = {
          high = 80;
          medium = 40;
          low = 20;
        };
        tooltip = false;
      };

      clock = {
        format = "{:%a, %b %d %y, %I:%M %p}";
        tooltip = false;
      };

      "hyprland/window" = {
        max-length = 100;
        separate-outputs = true;
      };

      "hyprland/workspaces" = {
        # format = "{id} {windows}"; TODO: setup rewrite rules for this
        show-special = true;
      };

      network = {
        format-wifi = "󰤨   {essid}";
        format-disconnected = "󰤮   N/A";
        tooltip = false;
      };

      pulseaudio = {
        format = "{icon}   {volume:0>3}";
        format-muted = "󰝟   {volume:0>3}";
        format-icons = {
          headphone = "󰋋";
          default = [ "" "" "󰕾" "󰕾" "󰕾" "" "" "" ];
        };
        states = {
          low = 15;
        };
        tooltip = false;
      };

      tray = {
        spacing = 10;
      };
    }];

    style = ''
      * {
        min-height: 0;
        color: @base05;
        border-radius: 0;
        border-width: 0;
      }

      .modules-right {
        margin-right: 10px;
      }

      /* green */
      #backlight,
      #battery.charging,
      #battery.high,
      #network.wifi,
      #pulseaudio.low,
      #workspaces button.active {
        border-bottom: 4px solid @base0B;
      }

      /* yellow */
      #backlight.medium,
      #battery.medium:not(.charging),
      #pulseaudio:not(.low) {
        border-bottom: 4px solid @base0A;
      }

      /* red */
      #backlight.high,
      #battery.low,
      #network.disconnected,
      #pulseaudio.muted,
      #workspaces button.urgent,
      #tray > .needs-attention {
        border-bottom: 4px solid @base08;
      }
    '';
  };
}
