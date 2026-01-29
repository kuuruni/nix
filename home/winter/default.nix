{ pkgs, ... }:

{
  imports = [
    ./hyprland-config.nix
  ];

  home.username = "winter";
  home.homeDirectory = "/home/winter";
  home.stateVersion = "25.11";
  home.packages = with pkgs; [
    fastfetch
    btop
    git
    brave
    chromium
    vlc
  ];

  programs.bash.enable = true;
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
  };

  programs.home-manager.enable = true;
}