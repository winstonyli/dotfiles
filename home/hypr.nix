{ config, inputs, pkgs, ... }:

{
  imports = [ inputs.hyprland.homeManagerModules.default ];

  home.packages = with pkgs; [
    inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
    inputs.hyprpaper.packages.${pkgs.system}.default
  ];

  xdg.configFile."hypr/wallpaper.webp".source = config.stylix.image;
  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = ~/.config/hypr/wallpaper.webp
    wallpaper = , ~/.config/hypr/wallpaper.webp
    ipc = off
  '';

  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.settings = {
    exec = [
      "killall .waybar-wrapped; waybar"
      "killall hyprpaper; hyprpaper"
      "fcitx5 -dr"
    ];

    monitor = [ ",preferred,auto,1.175" ];

    general = {
      border_size = 1;
      # border_size = 0;
      gaps_in = 0;
      gaps_out = 0;
      no_focus_fallback = true;
    };

    dwindle.pseudotile = true;

    decoration = {
      # For battery life
      blur.enabled = false;
      drop_shadow = false;

      dim_inactive = true;
      dim_strength = 0.3;
      dim_special = 0.3;
    };

    animations = {
      # comment out when battery life is not a concern
      enabled = false;

      animation = [
        "windows    , 1, 3, default"
        "fade       , 1, 5, default"
        "border     , 1, 3, default"
        "borderangle, 0            "
        "workspaces , 1, 3, default"
      ];
    };

    input = {
      repeat_delay = 300;
      sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
      touchpad = {
        disable_while_typing = true;
        natural_scroll = true;
        scroll_factor = 0.5;
        clickfinger_behavior = true;
        tap-to-click = false;
      };
    };

    binds = {
      scroll_event_delay = 0;
      allow_workspace_cycles = true;
    };

    misc = {
      # Excise degeneracy
      disable_hyprland_logo = true;
      force_default_wallpaper = 0;

      disable_autoreload = true;
      enable_swallow = true;
      new_window_takes_over_fullscreen = 2;
    };

    ############
    # KEYBINDS #
    ############

    # https://wiki.hyprland.org/Configuring/Binds/
    bind = [
      "SUPER SHIFT, Q  , killactive        "
      "SUPER      , A  , togglefloating    "
      "SUPER      , Tab, focuscurrentorlast"
      "SUPER      , Tab, alterzorder, top  "

      # Convenience keybinds
      "SUPER      , R, exec          , hyprctl reload                  "
      "SUPER      , F, fullscreen    , 0                               "
      "SUPER SHIFT, F, fakefullscreen, 0                               "
      "SUPER      , S, exec          , grimblast --freeze copysave area"

      # Launch applications
      "SUPER, Return, exec, foot  "
      "SUPER, D     , exec, fuzzel"

      # Move focus with SUPER HJKL
      "SUPER, H, movefocus, l"
      "SUPER, J, movefocus, d"
      "SUPER, K, movefocus, u"
      "SUPER, L, movefocus, r"

      # Move window with SUPER SHIFT HJKL
      "SUPER SHIFT, H, movewindow, l"
      "SUPER SHIFT, J, movewindow, d"
      "SUPER SHIFT, K, movewindow, u"
      "SUPER SHIFT, L, movewindow, r"

      # Switch workspaces with SUPER 0-9
      "SUPER, 1, workspace, 1"
      "SUPER, 2, workspace, 2"
      "SUPER, 3, workspace, 3"
      "SUPER, 4, workspace, 4"
      "SUPER, 5, workspace, 5"
      "SUPER, 6, workspace, 6"
      "SUPER, 7, workspace, 7"
      "SUPER, 8, workspace, 8"
      "SUPER, 9, workspace, 9"
      "SUPER, 0, workspace, 10"

      # Move window to workspace with SUPER SHIFT 0-9
      "SUPER SHIFT, 1, movetoworkspacesilent, 1"
      "SUPER SHIFT, 2, movetoworkspacesilent, 2"
      "SUPER SHIFT, 3, movetoworkspacesilent, 3"
      "SUPER SHIFT, 4, movetoworkspacesilent, 4"
      "SUPER SHIFT, 5, movetoworkspacesilent, 5"
      "SUPER SHIFT, 6, movetoworkspacesilent, 6"
      "SUPER SHIFT, 7, movetoworkspacesilent, 7"
      "SUPER SHIFT, 8, movetoworkspacesilent, 8"
      "SUPER SHIFT, 9, movetoworkspacesilent, 9"
      "SUPER SHIFT, 0, movetoworkspacesilent, 10"

      # Move to scratchpad
      "SUPER      , Minus, togglespecialworkspace,        "
      "SUPER SHIFT, Minus, movetoworkspacesilent , special"
    ];

    bindm = [
      # Move/resize windows with SUPER LMB/RMB drag
      "SUPER, mouse:272, movewindow  "
      "SUPER, mouse:273, resizewindow"
    ];

    binde = [
      # Control volume
      "     , XF86AudioMute       , exec, wpctl set-mute   @DEFAULT_SINK@ toggle"
      "     , XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_SINK@ 1%-   "
      "SUPER, XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_SINK@ 10%-  "
      "     , XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_SINK@ 1%+   "
      "SUPER, XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_SINK@ 10%+  "

      # Control brightness
      "     , XF86MonBrightnessDown, exec, brillo -u  40000 -q -U 1           "
      "SUPER, XF86MonBrightnessDown, exec, brillo -u 200000    -S $(brillo -c)" # set to min
      "     , XF86MonBrightnessUp  , exec, brillo -u  40000 -q -A 1           "
      "SUPER, XF86MonBrightnessUp  , exec, brillo -u 200000    -S $(brillo -m)" # set to max
    ];

    windowrule = [
      "float, fcitx"
      #"tile , gamescope"
    ];
  };
}
