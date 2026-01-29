{
  self,
  lib,
  pkgs,
  inputs,
  ...
}:

let
  # helper to handle module mapping
  mapModules =
    dir: fn:
    if !builtins.pathExists dir then
      { }
    else
      lib.mapAttrs (name: type: fn (dir + "/${name}")) (
        lib.filterAttrs (
          name: type: (type == "directory" || (lib.hasSuffix ".nix" name && name != "default.nix"))
        ) (builtins.readDir dir)
      );
in
rec {
  inherit mapModules;

  mapHosts =
    dir:
    if !builtins.pathExists dir then
      { }
    else
      lib.mapAttrs (
        name: type:
        lib.nixosSystem {
          # Ensure the system is inherited correctly from pkgs or inputs
          system = "x86_64-linux";
          specialArgs = { inherit inputs self lib; };
          modules = [
            { networking.hostName = name; }
            (dir + "/${name}")
          ];
        }
      ) (lib.filterAttrs (name: type: type == "directory") (builtins.readDir dir));

  mkFlake =
    inputs: attrs:
    attrs
    // {
      nixosConfigurations = attrs.hosts or { };
    };
}
