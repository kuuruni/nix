{ config, pkgs, ... }:

{
  # Set resolution and refresh rate at the kernel level (KMS)
  # 'eDP-1' is the standard name for internal laptop displays
  boot.kernelParams = [ "video=eDP-1:1920x1080@59" ];

  # For X11 (if you use it)
  services.xserver.displayManager.sessionCommands = ''
    ${pkgs.xorg.xrandr}/bin/xrandr --output eDP-1 --mode 1920x1080 --rate 59.00
  '';

  # High DPI / Scaling settings (optional for 1080p, but good to have)
  # console.font = "${pkgs.terminus_font}/share/consolefonts/ter-v24n.psf.gz";
}
