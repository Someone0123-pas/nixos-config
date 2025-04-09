{ config, pkgs, inputs, system, ... }:

{
  imports = [
    ./kitty.nix
    ./vscodium.nix
  ];

  home.packages = with pkgs; [
    neofetch
    discord
    dolphin-emu
    desmume
    mgba
    aseprite
    godot_4
    onlyoffice-desktopeditors
    ghidra
    mangohud
    geogebra6
    prismlauncher
    mdbook
    yt-dlp
    clang-manpages
    okteta
    kdePackages.kfind
    /*
    ( texliveBasic.withPackages (ps: with texlivePackages; [
      beamer ucs babel-german inputenx multirow listings ulem times
    ]))
    */
    (texliveSmall.withPackages (ps: with texlivePackages; [
      inputenx multirow
    ]))
  ] ++ [
    inputs.zen-browser.packages."${system}".default
  ];

  programs = {
    git = {
      enable = true;
      userName = "Someone0123-pas";
      userEmail = "Jemand0123@protonmail.com";
      extraConfig = {
        advice.addIgnoredFile = false;
	pull.rebase = false;
      };
    };
    htop.enable = true;
    firefox = {
      enable = true;
    };
  };
}
