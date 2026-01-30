{ pkgs, ... }:

{
  home.packages = with pkgs; [
    pavucontrol
    blueman
  ];

  programs.waybar = {
    enable = true;
    systemd.enable = true;
    systemd.target = "hyprland-session.target";

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 40;
        margin-top = 10;
        margin-left = 10;
        margin-right = 10;
        spacing = 4;

        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "clock" ];
        modules-right = [
          "tray"
          "pulseaudio"
          "network"
          "battery"
        ];

        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            "1" = "󰎤";
            "2" = "󰎧";
            "3" = "󰎪";
            "4" = "󰎭";
            "5" = "󰎱";
            urgent = "󰀨";
            default = "󰑊";
          };
          persistent-workspaces = {
            "*" = 5;
          };
        };

        clock = {
          format = "󰥔  {:%H:%M}";
          format-alt = "󰃭  {:%A, %B %d}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "month";
            format = {
              today = "<span color='#f38ba8'><b>{}</b></span>";
            };
          };
        };

        tray = {
          icon-size = 16;
          spacing = 8;
        };

        pulseaudio = {
          format = "{icon}  {volume}%";
          format-muted = "󰖁  muted";
          format-icons = {
            default = [ "󰕿" "󰖀" "󰕾" ];
            headphone = "󰋋";
          };
          on-click = "pavucontrol";
          tooltip = false;
          scroll-step = 5;
        };

        network = {
          format-wifi = "󰤨  {signalStrength}%";
          format-ethernet = "󰈀  wired";
          format-disconnected = "󰤭  offline";
          tooltip-format-wifi = "{essid}\n{ipaddr}/{cidr}";
          tooltip-format-ethernet = "{ifname}\n{ipaddr}/{cidr}";
          on-click = "nm-connection-editor";
        };

        battery = {
          states = {
            good = 95;
            warning = 30;
            critical = 15;
          };
          format = "{icon}  {capacity}%";
          format-charging = "󰂄  {capacity}%";
          format-plugged = "󰚥  {capacity}%";
          format-icons = [ "󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
          tooltip-format = "{timeTo}";
        };
      };
    };

    style = builtins.readFile ./style.css;
  };
}