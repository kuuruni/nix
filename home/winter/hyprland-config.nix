{ ... }:

let
  wallpaperPath = ./assets/winter.jpeg;
in
{
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

      "$mainMod" = "SUPER";
      bind = [
        "$mainMod, T, exec, kitty"
        "$mainMod, Q, killactive,"
        "$mainMod, R, exec, walker"
      ];

      cursor = {
        no_hardware_cursors = true;
      };

      exec-once = [
        "swww-daemon"
        "swww img ${wallpaperPath} --transition-type grow"
        "waybar"
        "dunst"
        "walker --gapplication-service"
      ];
    };
  };
}
