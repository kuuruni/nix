{ pkgs, ... }:

{
  home.packages = with pkgs; [
    pavucontrol
    networkmanagerapplet
  ];

  programs.waybar = {
    enable = true;
    systemd.enable = true;
    systemd.target = "hyprland-session.target";
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 38;
        margin-top = 6;
        margin-left = 10;
        margin-right = 10;
        spacing = 0;

        modules-left = [
          "hyprland/workspaces"
          "hyprland/window"
        ];
        modules-center = [ "clock" ];
        modules-right = [
          "tray"
          "network"
          "bluetooth"
          "pulseaudio"
          "backlight"
          "battery"
          "custom/power"
        ];

        "hyprland/workspaces" = {
          format = "{icon}";
          on-click = "activate";
          on-scroll-up = "hyprctl dispatch workspace e-1";
          on-scroll-down = "hyprctl dispatch workspace e+1";
          all-outputs = true;
          format-icons = {
            "1" = "󰎤";
            "2" = "󰎧";
            "3" = "󰎪";
            "4" = "󰎭";
            "5" = "󰎱";
            "6" = "󰎳";
            "7" = "󰎶";
            "8" = "󰎹";
            "9" = "󰎼";
            "10" = "󰽽";
            "urgent" = "󰀨";
            "active" = "󰮯";
            "default" = "󰊠";
          };
          persistent-workspaces = {
            "*" = 5;
          };
        };

        "hyprland/window" = {
          format = "{}";
          max-length = 40;
          separate-outputs = true;
          rewrite = {
            "" = " Desktop";
          };
        };

        "clock" = {
          format = "󰥔 {:%H:%M}";
          format-alt = "󰃭 {:%A, %B %d, %Y}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "year";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            format = {
              months = "<span color='#cba6f7'><b>{}</b></span>";
              days = "<span color='#cdd6f4'><b>{}</b></span>";
              weeks = "<span color='#89dceb'><b>W{}</b></span>";
              weekdays = "<span color='#f9e2af'><b>{}</b></span>";
              today = "<span color='#f38ba8'><b><u>{}</u></b></span>";
            };
          };
          actions = {
            on-click-right = "mode";
            on-scroll-up = "shift_up";
            on-scroll-down = "shift_down";
          };
        };

        "cpu" = {
          format = "󰻠 {usage}%";
          interval = 2;
          on-click = "kitty -e btop";
        };

        "memory" = {
          format = "󰍛 {percentage}%";
          interval = 2;
          on-click = "kitty -e btop";
        };

        "pulseaudio" = {
          format = "{icon} {volume}%";
          format-muted = "󰝟 ";
          format-icons = {
            headphone = "󰋋";
            headset = "󰋎";
            default = [ "󰕿" "󰖀" "󰕾" ];
          };
          on-click = "pavucontrol";
          on-click-right = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          scroll-step = 5;
        };

        "network" = {
          format-wifi = "󰤨 {signalStrength}%";
          format-ethernet = "󰈀 Wired";
          format-disconnected = "󰤭 ";
          tooltip-format-wifi = "{essid} ({signalStrength}%)\n{ipaddr}/{cidr}";
          tooltip-format-ethernet = "{ifname}\n{ipaddr}/{cidr}";
          on-click = "nm-connection-editor";
        };

        "bluetooth" = {
          format = "󰂯";
          format-connected = "󰂱 {device_alias}";
          format-disabled = "󰂲";
          tooltip-format = "{controller_alias}\t{controller_address}";
          tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
          on-click = "blueman-manager";
        };

        "backlight" = {
          format = "{icon} {percent}%";
          format-icons = [ "󰃞" "󰃟" "󰃠" ];
          on-scroll-up = "brightnessctl set +5%";
          on-scroll-down = "brightnessctl set 5%-";
        };

        "battery" = {
          states = {
            good = 80;
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = "󰂄 {capacity}%";
          format-plugged = "󰂄 {capacity}%";
          format-icons = [ "󰂃" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
          tooltip-format = "{timeTo}\n{power}W";
        };

        "tray" = {
          icon-size = 16;
          spacing = 8;
        };

        "custom/power" = {
          format = "⏻";
          tooltip = false;
          on-click = "wlogout";
        };
      };
    };

    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font", "Font Awesome 6 Free";
        font-size: 13px;
        min-height: 0;
      }

      window#waybar {
        background: transparent;
        color: #cdd6f4;
      }

      tooltip {
        background: #1e1e2e;
        border: 1px solid #cba6f7;
        border-radius: 12px;
      }

      tooltip label {
        color: #cdd6f4;
      }

      /* Left modules */
      #workspaces {
        background: #1e1e2e;
        border-radius: 16px;
        margin: 4px 4px 4px 8px;
        padding: 0 8px;
        border: 1px solid #313244;
      }

      #workspaces button {
        color: #45475a;
        padding: 4px 8px;
        margin: 4px 2px;
        border-radius: 12px;
        background: transparent;
        transition: all 0.2s ease;
      }

      #workspaces button:hover {
        color: #cba6f7;
        background: #313244;
      }

      #workspaces button.active {
        color: #1e1e2e;
        background: linear-gradient(135deg, #cba6f7, #89b4fa);
      }

      #workspaces button.urgent {
        color: #1e1e2e;
        background: #f38ba8;
      }

      #window {
        background: #1e1e2e;
        border-radius: 16px;
        margin: 4px;
        padding: 0 16px;
        border: 1px solid #313244;
        color: #a6adc8;
      }

      /* Center modules */
      #clock {
        background: linear-gradient(135deg, #1e1e2e, #181825);
        border-radius: 16px;
        margin: 4px;
        padding: 0 16px;
        border: 1px solid #cba6f7;
        color: #cba6f7;
        font-weight: bold;
      }

      /* Right modules */
      #network,
      #bluetooth,
      #pulseaudio,
      #backlight,
      #battery,
      #cpu,
      #memory,
      #tray {
        background: #1e1e2e;
        border-radius: 16px;
        margin: 4px 2px;
        padding: 0 12px;
        border: 1px solid #313244;
      }

      #tray {
        margin-right: 4px;
      }

      #network {
        color: #89dceb;
      }

      #bluetooth {
        color: #89b4fa;
      }

      #bluetooth.connected {
        color: #a6e3a1;
      }

      #pulseaudio {
        color: #fab387;
      }

      #pulseaudio.muted {
        color: #6c7086;
      }

      #backlight {
        color: #f9e2af;
      }

      #battery {
        color: #a6e3a1;
      }

      #battery.charging {
        color: #a6e3a1;
      }

      #battery.warning:not(.charging) {
        color: #f9e2af;
      }

      #battery.critical:not(.charging) {
        color: #f38ba8;
        animation: pulse 1s infinite;
      }

      @keyframes pulse {
        0%, 100% { opacity: 1; }
        50% { opacity: 0.5; }
      }

      #cpu {
        color: #74c7ec;
      }

      #memory {
        color: #94e2d5;
      }

      #custom-power {
        background: #f38ba8;
        color: #1e1e2e;
        border-radius: 16px;
        margin: 4px 8px 4px 2px;
        padding: 0 14px;
        font-weight: bold;
      }

      #custom-power:hover {
        background: #eba0ac;
      }
    '';
  };
}