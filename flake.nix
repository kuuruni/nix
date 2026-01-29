{
  description = "xnixma";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:nixos/nixos-hardware";
  };

  outputs = inputs @ { self, nixpkgs, ... }:
    let
      args = {
        inherit self inputs;
        inherit (nixpkgs) lib;
        pkgs = import nixpkgs { 
          system = "x86_64-linux";
          config.allowUnfree = false; 
        };
      };
      
      lib = import ./lib args;
    in
      with builtins; with lib; mkFlake inputs {
        systems = [ "x86_64-linux" ];
        inherit lib;

        hosts = mapHosts ./hosts;

        # System-wide modules
        modules.default = import ./.;

        # Developer environments (TS, Go, etc.)
        devShells.default = import ./shell.nix;
        
        # Extensions
        checks = mapModules ./test import;
        overlays = mapModules ./overlays import;
        packages = mapModules ./packages import;
      };
}