{ pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true; 
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  environment.systemPackages = with pkgs; [
    waybar           
    swww             
    kitty            
    # rofi-wayland   
    vicinae
    libnotify        
    dunst            
  ];

  hardware.graphics.enable = true;
}