{ pkgs, ... }:

{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      manager = {
        show_hidden = true;
        sort_by = "natural";
        sort_sensitive = false;
        sort_reverse = false;
        sort_dir_first = true;
        linemode = "size";
      };

      opener = {
        edit = [
          {
            run = ''''${EDITOR:-nvim} "$@"'';
            block = true;
          }
        ];
        play = [
          {
            run = ''vlc "$@"'';
            orphan = true;
          }
        ];
      };
    };
  };

  home.packages = with pkgs; [
    file
    exiftool
    poppler
    ffmpegthumbnailer
  ];
}
