{ pkgs, config, ... }:

{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    terminal = "kitty";
    extraConfig = {
      modi = "drun,run,window,filebrowser";
      show-icons = true;
      icon-theme = "Papirus-Dark";
      drun-display-format = "{name}";
      disable-history = false;
      hide-scrollbar = true;
      display-drun = " ";
      display-run = " ";
      display-window = " ";
      display-filebrowser = " ";
      sidebar-mode = false;
      hover-select = true;
      me-select-entry = "";
      me-accept-entry = "MousePrimary";
    };
    theme = let
      inherit (config.lib.formats.rasi) mkLiteral;
    in {
      "*" = {
        bg0 = mkLiteral "#1e1e2e";
        bg1 = mkLiteral "#313244";
        bg2 = mkLiteral "#45475a";
        fg0 = mkLiteral "#cdd6f4";
        fg1 = mkLiteral "#bac2de";
        accent = mkLiteral "#cba6f7";
        urgent = mkLiteral "#f38ba8";

        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@fg0";

        margin = 0;
        padding = 0;
        spacing = 0;
      };

      window = {
        background-color = mkLiteral "@bg0";
        border = mkLiteral "2px";
        border-color = mkLiteral "@accent";
        border-radius = mkLiteral "12px";
        width = mkLiteral "600px";
        location = mkLiteral "center";
        anchor = mkLiteral "center";
      };

      inputbar = {
        padding = mkLiteral "16px";
        spacing = mkLiteral "12px";
        children = map mkLiteral [ "icon-search" "entry" ];
        background-color = mkLiteral "@bg1";
        border-radius = mkLiteral "12px 12px 0 0";
      };

      "icon-search" = {
        expand = false;
        filename = "search";
        size = mkLiteral "24px";
        vertical-align = mkLiteral "0.5";
      };

      entry = {
        placeholder = "Search...";
        placeholder-color = mkLiteral "@fg1";
        vertical-align = mkLiteral "0.5";
      };

      listview = {
        lines = 8;
        columns = 1;
        fixed-height = true;
        padding = mkLiteral "8px";
        spacing = mkLiteral "4px";
      };

      element = {
        padding = mkLiteral "12px 16px";
        spacing = mkLiteral "12px";
        border-radius = mkLiteral "8px";
      };

      "element normal normal, element alternate normal" = {
        background-color = mkLiteral "transparent";
      };

      "element selected normal" = {
        background-color = mkLiteral "@accent";
        text-color = mkLiteral "@bg0";
      };

      "element selected urgent" = {
        background-color = mkLiteral "@urgent";
        text-color = mkLiteral "@bg0";
      };

      element-icon = {
        size = mkLiteral "24px";
        vertical-align = mkLiteral "0.5";
      };

      element-text = {
        vertical-align = mkLiteral "0.5";
      };

      "element-text selected" = {
        text-color = mkLiteral "@bg0";
      };
    };
  };
}