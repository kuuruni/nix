{ pkgs, ... }:

{
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Jakarta";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    git
    pciutils # Useful for checking Intel hardware
  ];

  system.stateVersion = "25.11";
}