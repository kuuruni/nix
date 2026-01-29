{ pkgs, ... }:

{
  home.packages = [ pkgs.swww ];

  systemd.user.services.swww = {
    Unit = {
      Description = "Wallpaper daemon";
      After = [ "graphical-session.target" ];
      Partof = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.swww}/bin/swww-daemon";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
