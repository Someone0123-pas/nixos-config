{ config, pkgs, ...}:

{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
  };
}
