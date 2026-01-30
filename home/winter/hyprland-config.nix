{ pkgs, ... }:

let
  wallpaperPath = ./assets/winter.jpeg;
in
{
  home.packages = with pkgs; [
    hyprpaper
    hyprpicker
    grimblast
    brightnessctl
    jq
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = [
        "eDP-1, 1920x1080@59, 0x1080, 1"
        "HDMI-A-1, highres, 0x0, 1"
      ];

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        layout = "dwindle";
      };

      decoration = {
        rounding = 10;
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
      };

      input = {
        kb_layout = "us";
        follow_mouse = 1;
        touchpad.natural_scroll = true;
      };

      "$mainMod" = "ALT";
      "$moveactivewindow" =
        "grep -q 'true' <<< $(hyprctl activewindow -j | jq -r .floating) && hyprctl dispatch moveactive";

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
        "$mainMod, Z, movewindow"
        "$mainMod, X, resizewindow"
      ];

      binde = [
        "$mainMod Shift, Right , resizeactive, 30 0"
        "$mainMod Shift, Left, resizeactive, -30 0"
        "$mainMod Shift, Up, resizeactive, 0 -30"
        "$mainMod Shift, Down, resizeactive, 0 30"
      ];

      bind = [
        # Terminal and apps
        "$mainMod, T, exec, kitty"
        "$mainMod, Q, killactive"
        "$mainMod, E, exec, kitty -e yazi"

        # Rofi
        "$mainMod, R, exec, rofi -show drun"
        "$mainMod, Tab, exec, rofi -show window"
        "$mainMod SHIFT, R, exec, rofi -show run"

        # Focus
        "$mainMod, Left, movefocus, l"
        "$mainMod, Right, movefocus, r"
        "$mainMod, Up, movefocus, u"
        "$mainMod, Down, movefocus, d"
        "ALT, Tab, cyclenext"

        # Move windows
        "$mainMod SHIFT CONTROL, Left, exec, $moveactivewindow -30 0 || hyprctl dispatch movewindow l"
        "$mainMod SHIFT CONTROL, Right, exec, $moveactivewindow 30 0 || hyprctl dispatch movewindow r"
        "$mainMod SHIFT CONTROL, Up, exec, $moveactivewindow 0 -30 || hyprctl dispatch movewindow u"
        "$mainMod SHIFT CONTROL, Down, exec, $moveactivewindow 0 30 || hyprctl dispatch movewindow d"

        # Layout & Window states
        "$mainMod, J, togglesplit"
        "$mainMod, W, togglefloating"
        "$mainMod, G, togglegroup"
        "SHIFT, F11, fullscreen"

        # Audio (wpctl)
        ", F10, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", F11, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", F12, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"

        # Brightness
        ", XF86MonBrightnessUp, exec, brightnessctl set +5%"
        ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"

        # Screenshots & color picker
        "$mainMod SHIFT, P, exec, hyprpicker -an"
        "$mainMod, P, exec, grimblast copy area"
        "$mainMod CONTROL, P, exec, grimblast --freeze copy area"
        "$mainMod ALT, P, exec, grimblast copy output"
        ", Print, exec, grimblast copy screen"

        # Groups
        "$mainMod CONTROL, H, changegroupactive, b"
        "$mainMod CONTROL, L, changegroupactive, f"

        # Workspaces
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Move to workspace
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # Relative workspace
        "$mainMod CONTROL ALT, Right, movetoworkspace, r+1"
        "$mainMod CONTROL ALT, Left, movetoworkspace, r-1"
        "$mainMod CONTROL, Right, workspace, r+1"
        "$mainMod CONTROL, Left, workspace, r-1"
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"

        # Scratchpad
        "$mainMod SHIFT, S, movetoworkspace, special"
        "$mainMod ALT, S, movetoworkspacesilent, special"
        "$mainMod, S, togglespecialworkspace,"

        # Silent move
        "$mainMod ALT, 1, movetoworkspacesilent, 1"
        "$mainMod ALT, 2, movetoworkspacesilent, 2"
        "$mainMod ALT, 3, movetoworkspacesilent, 3"
        "$mainMod ALT, 4, movetoworkspacesilent, 4"
        "$mainMod ALT, 5, movetoworkspacesilent, 5"
        "$mainMod ALT, 6, movetoworkspacesilent, 6"
        "$mainMod ALT, 7, movetoworkspacesilent, 7"
        "$mainMod ALT, 8, movetoworkspacesilent, 8"
        "$mainMod ALT, 9, movetoworkspacesilent, 9"
        "$mainMod ALT, 0, movetoworkspacesilent, 10"
      ];

      cursor = {
        no_hardware_cursors = true;
      };

      exec-once = [
        "hyprpaper"
        "dunst"
      ];
    };
  };

  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = ${wallpaperPath}
    wallpaper = ,${wallpaperPath}
    splash = false
  '';
}
