{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = (
      pkgs.vscode.override {
        commandLineArgs = [
          "--enable-features=UseOzonePlatform"
          "--ozone-platform=wayland"
        ];
      }
    );

    profiles =
      let
        sharedExtensions = with pkgs.vscode-extensions; [
          catppuccin.catppuccin-vsc
          catppuccin.catppuccin-vsc-icons
          jnoortheen.nix-ide
        ];
      in
      {
        default = {
          extensions = sharedExtensions;
          userSettings = {
            "workbench.colorTheme" = "Catppuccin Mocha";
            "nix.enableLanguageServer" = true;
          };
        };

        typescript = {
          extensions =
            sharedExtensions
            ++ (with pkgs.vscode-extensions; [
            ]);
          userSettings = {

          };
        };

        devops = {
          extensions =
            sharedExtensions
            ++ (with pkgs.vscode-extensions; [
              redhat.vscode-yaml
              ms-azuretools.vscode-docker
              ms-kubernetes-tools.vscode-kubernetes-tools
            ]);
          userSettings = {
            "yaml.schemas" = {
              "kubernetes" = "*.yaml";
            };
          };
        };
      };
  };
}
