{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;

    font = {
      name = "JetBrainsMono Nerd Font";
      size = 11;
    };

    settings = {
      tab_title_template = "{index}{'-({})'.format(num_windows) if num_windows > 1 else ''} {title[:20]}";
      scrollback_lines = 10000;
      enable_audio_bell = false;
      update_check_interval = 0;
      window_padding_width = 15;
      confirm_os_window_close = 0;
      background_opacity = "0.85";

      tab_bar_edge = "bottom";
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";

      mouse_hide_wait = "3.0";
    };

    themeFile = "Catppuccin-Mocha";

    keybindings = {
      "ctrl+shift+t" = "new_tab_with_cwd";
    };

    extraConfig = ''
      mouse_map left click ungrabbed no-op
      mouse_map ctrl+left click ungrabbed mouse_handle_click selection link prompt
      mouse_map ctrl+left press ungrabbed mouse_selection normal

      # Performance tweaks (Note: sync_to_monitor no might cause tearing in VM)
      # input_delay 0
      # repaint_delay 2
      # sync_to_monitor no
    '';
  };
}
