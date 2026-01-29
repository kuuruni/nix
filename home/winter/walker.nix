{ ... }:

{
  xdg.configFile."walker/config.json".text = builtins.toJSON {
    terminal = "kitty";
    fullscreen = false;
    show_initial_entries = true;
    shell_config = {
      shell = "zsh";
    };
    app_launch_prefix = "";
    selection_prefix = "❯";

    modules = [
      {
        name = "applications";
        prefix = "";
      }
      {
        name = "ssh";
        prefix = "ssh ";
      }
      {
        name = "finder";
        prefix = "f ";
      }
      {
        name = "commands";
        prefix = "!";
      }
    ];
  };

  xdg.configFile."walker/style.css".text = ''
    #window {
      background: transparent;
    }

    #box {
      background: #1e1e2e; /* Catppuccin Mocha Base */
      border: 2px solid #89b4fa; /* Blue accent border */
      border-radius: 12px;
      padding: 10px;
    }

    #search {
      background: #313244;
      border: none;
      border-radius: 8px;
      padding: 8px;
      color: #cdd6f4;
    }

    #entry:selected {
      background: #45475a;
      border-radius: 6px;
    }

    #text {
      color: #cdd6f4;
    }

    #subtext {
      color: #6c7086;
    }
  '';
}
