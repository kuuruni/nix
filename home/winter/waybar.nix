{ ... }:

{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        margin-top = 5;
        margin-left = 10;
        margin-right = 10;
        spacing = 4;

        modules-left = [
          "hyprland/workspaces"
          "hyprland/window"
        ];
        modules-center = [ "clock" ];
        modules-right = [
          "network"
          "cpu"
          "memory"
          "pulseaudio"
          "tray"
        ];

        "hyprland/workspaces" = {
          format = "{icon}";
          on-click = "activate";
          format-icons = {
            "1" = "";
            "2" = "";
            "3" = "";
            "4" = "󰙯";
            "5" = "";
            "urgent" = "";
            "active" = "";
            "default" = "";
          };
        };

        "clock" = {
          format = " {:%H:%M}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };

        "cpu" = {
          format = " {usage}%";
        };

        "memory" = {
          format = " {percentage}%";
        };

        "pulseaudio" = {
          format = "{icon} {volume}%";
          format-muted = "󰝟 Muted";
          format-icons = {
            default = [
              ""
              ""
              ""
            ];
          };
          on-click = "pavucontrol";
        };

        "network" = {
          format-wifi = " {essid}";
          format-ethernet = "󰈀 Wired";
          format-disconnected = "󰖪 Off";
        };
      };
    };

    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font", Roboto, Helvetica, Arial, sans-serif;
        font-size: 13px;
        border: none;
        border-radius: 0;
      }

      window#waybar {
        background-color: rgba(24, 24, 37, 0); /* Invisible background for islands */
        color: #cdd6f4;
      }

      #workspaces, #clock, #window, #network, #cpu, #memory, #pulseaudio, #tray {
        background-color: #1e1e2e;
        padding: 0 10px;
        margin: 0 5px;
        border-radius: 15px;
        border: 1px solid #313244;
      }

      #workspaces button {
        padding: 0 5px;
        color: #585b70;
      }

      #workspaces button.active {
        color: #89b4fa;
      }

      #workspaces button.urgent {
        color: #f38ba8;
      }
    '';
  };
}
