{ config, pkgs, lib, ... }:

{
  home.username = "suraj";
  home.homeDirectory = "/home/suraj";
  home.stateVersion = "25.05";

  home.packages = with pkgs; [

    # CLI Tools
    hello
    ffmpeg

    # Editors
    neovim

    # Browsers & Media
    brave
    vlc
    youtube-music

    # Utilities
    menulibre
    gnome-pomodoro
  ];
 

  home.file = {};

  programs.home-manager.enable = true;
}
