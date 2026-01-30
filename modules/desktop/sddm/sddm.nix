{ pkgs, ... }:

let
  themeConf = ./theme.conf;
  backgroundImage = ./ice_princess.png;

  obscure = pkgs.stdenv.mkDerivation {
    name = "obscure";
    # Point this to where your theme files are
    src = pkgs.fetchFromGitHub {
      owner = "saatvik333";
      repo = "obscure-sddm-theme";
      rev = "main";
      sha256 = "sha256-WMx1SSG1L687ScPSeaZa4FuIoZSdnUidB3n44vyLCwY=";
    };
    installPhase = ''
      mkdir -p $out/share/sddm/themes/obscure
      cp -aR $src/. $out/share/sddm/themes/obscure/
      chmod -R +w $out/share/sddm/themes/obscure
      cp ${themeConf} $out/share/sddm/themes/obscure/theme.conf
      mkdir -p $out/share/sddm/themes/obscure/assets
      cp ${backgroundImage} $out/share/sddm/themes/obscure/assets/ice_princess.pn
    '';
  };
in
{
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "obscure";

    package = pkgs.kdePackages.sddm;

    extraPackages = with pkgs.kdePackages; [
      qt5compat
      qtmultimedia
      qtsvg
    ];
  };

  environment.systemPackages = [ obscure ];
}
