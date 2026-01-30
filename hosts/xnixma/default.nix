{
  pkgs,
  config,
  lib,
  inputs,
  ...
}:

{
  imports = [
    ./hardware.nix
    ../../modules/core
    ../../modules/hardware/intel.nix
    ../../modules/hardware/display.nix
    ../../modules/desktop/hyprland.nix
    ../../modules/desktop/sddm/sddm.nix
    inputs.home-manager.nixosModules.home-manager
  ];

  programs.zsh.enable = true;

  users.users.winter = {
    isNormalUser = true;
    description = "Winter";
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "audio"
    ];
    shell = pkgs.zsh;
    initialPassword = "7502";
  };

  # uncomment this part if want to test via vm
  # virtualisation.vmVariant = {
  #   virtualisation = {
  #     memorySize = 4096; 
  #     cores = 4; 
  #     qemu.options = [
  #       "-vga virtio"
  #       "-display gtk,zoom-to-fit=on"
  #       "-device virtio-tablet-pci"
  #     ];
  #   };
  # };

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
