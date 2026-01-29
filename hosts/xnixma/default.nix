{ pkgs, config, lib, inputs, ... }:

{
  imports = [
    ./hardware.nix
    ../../modules/core
    ../../modules/hardware/intel.nix
    ../../modules/hardware/display.nix
    ../../modules/desktop/hyprland.nix
    inputs.home-manager.nixosModules.home-manager
  ];

  programs.zsh.enable = true;

  users.users.winter = {
    isNormalUser = true;
    description = "Winter";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
    shell = pkgs.zsh;
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users.winter = import ../../home/winter;
  };

  time.timeZone = "Asia/Jakarta";
  i18n.defaultLocale = "en_US.UTF-8";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  system.stateVersion = "25.11"; 
}