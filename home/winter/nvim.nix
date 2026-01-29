{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    extraPackages = with pkgs; [
      lua-language-server
      nil
      nixpkgs-fmt
      stylua
      pyright

      ripgrep
      fd
      fzf
      git
      gcc
      gnumake
      unzip
      wl-clipboard
    ];
  };

  xdg.configFile."nvim".source = ./nvim-config;
}
