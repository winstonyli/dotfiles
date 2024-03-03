{ config, inputs, pkgs, ... }:

{
  home.packages = with pkgs; [
    inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
  ];

  wayland.windowManager.sway = {
    enable = true;
    package = pkgs.swayfx;
    wrapperFeatures.gtk = true;

    config = {
      # Functional settings
      modifier = "Mod4";

      menu = "fuzzel";
      terminal = "foot";

      startup = [{ command = "thorium"; }];

      # Cosmetic settings
      output = {
        "*" = {
          bg = "${config.stylix.image} fill";
        };
      };

      gaps = {
        inner = 4;
        left = 8;
        right = 8;
        bottom = 8;
      };

      # base00 base      #1e1e2e
      # base01 mantle    #181825
      # base02 surface0  #313244
      # base03 surface1  #45475a
      # base04 surface2  #585b70
      # base05 text      #cdd6f4
      # base06 rosewater #f5e0dc
      # base07 lavender  #b4befe
      # base08 red       #f38ba8
      # base09 peach     #fab387
      # base0A yellow    #f9e2af
      # base0B green     #a6e3a1
      # base0C teal      #94e2d5
      # base0D blue      #89b4fa
      # base0E mauve     #cba6f7
      # base0F flamingo  #f2cdcd

      colors = with config.lib.stylix.colors; {
        focused.border = base0E;
        unfocused.border = base04;
      };

      bars = [ ];
    };

    extraConfig = ''
      # Brightness
      bindsym XF86MonBrightnessDown exec light -U 10
      bindsym XF86MonBrightnessUp exec light -A 10

      # Volume
      bindsym XF86AudioRaiseVolume exec 'wpctl set-sink-volume @DEFAULT_SINK@ +1%'
      bindsym XF86AudioLowerVolume exec 'wpctl set-sink-volume @DEFAULT_SINK@ -1%'
      bindsym XF86AudioMute exec 'wpctl set-sink-mute @DEFAULT_SINK@ toggle'

      ### Idle configuration
      #
      # Example configuration:
      #
      # exec swayidle -w \
      #          timeout 300 'swaylock -f -c 000000' \
      #          timeout 600 'swaymsg "output * power off"' resume 'swaymsg "output * power on"' \
      #          before-sleep 'swaylock -f -c 000000'
      #
      # This will lock your screen after 300 seconds of inactivity, then turn off
      # your displays after another 300 seconds, and turn your screens back on when
      # resumed. It will also lock your screen before your computer goes to sleep.

      ### Input configuration
      #
      # Example configuration:
      #
      #   input "2:14:SynPS/2_Synaptics_TouchPad" {
      #       dwt enabled
      #       tap enabled
      #       natural_scroll enabled
      #       middle_emulation enabled
      #   }
      #
      # You can get the names of your inputs by running: swaymsg -t get_inputs
      # Read `man 5 sway-input` for more information about this section.

      #
      # Status Bar:
      #
      # Read `man 5 sway-bar` for more information about this section.
      bar {
          position top

          # When the status_command prints a new line to stdout, swaybar updates.
          # The default just shows the current date and time.
          status_command while date +'%Y-%m-%d %X'; do sleep 1; done

          colors {
              statusline #ffffff
              background #323232
              inactive_workspace #32323200 #32323200 #5c5c5c
          }
      }

      corner_radius 4
      default_dim_inactive 0.2
    '';
  };
}
