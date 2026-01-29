{ ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = [
        "eDP-1, 1920x1080@59, 0x1080, 1",
        "HDMI-A-1, highres, 0x0, 1"
      ];

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        layout = "dwindle";
      };

      input = {
        kb_layout = "us";
        follow_mouse = 1;
        touchpad.natural_scroll = true;
      };
    };
  };
}