{ self, lib, pkgs, inputs, ... }:

let
  # Internal helper to handle module mapping
  mapModules = dir: fn:
    lib.mapAttrs
      (name: type: fn (dir + "/${name}"))
      (lib.filterAttrs
        (name: type: (type == "directory" || (lib.hasSuffix ".nix" name && name != "default.nix")))
        (builtins.readDir dir));

in
rec {
  inherit mapModules;

  # mapHosts: Automatically discovers hosts in the ./hosts directory
  mapHosts = dir: 
    lib.mapAttrs 
      (name: type: 
        lib.nixosSystem {
          inherit (pkgs) system;
          specialArgs = { inherit inputs self lib; };
          modules = [
            { networking.hostName = name; }
            (dir + "/${name}")
          ];
        }
      )
      (lib.filterAttrs (name: type: type == "directory") (builtins.readDir dir));

  mkFlake = inputs: attrs: 
    let
      extendedAttrs = attrs // {
        nixosConfigurations = attrs.hosts or {};
      };
    in
    extendedAttrs;
}