{ config, lib, pkgs, ... }:

let
  cfg = config.default_display_manager;
in
{
  options = {
    default_display_manager = lib.mkOption {
      type = lib.types.enum [ "none" "sddm" ];
      default = "none";
      description = ''
	Auswahl des Displaymanagers:
	"none" (TTY mit startx, das xterm startet, und Skripten der einzelnen Desktop Environments)
	"sddm" (von KDE Plasma 6)
      '';
    };
  };

  config = {

    services.xserver.enable = true;
    services.desktopManager.plasma6.enable = false;
    # TODO Hyprland
    services.xserver.displayManager.startx.enable = (cfg == "none");
    services.displayManager.sddm.enable = (cfg == "sddm");

  };

}
