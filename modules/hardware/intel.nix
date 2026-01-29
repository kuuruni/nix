{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.nixos-hardware.nixosModules.common-pc-laptop-ssd
  ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      libvdpau-va-gl
    ];
  };

  services.thermald.enable = true; 
  
  hardware.cpu.intel.updateMicrocode = true;
}