{ config, pkgs, system, inputs, ... }:
let
  devshelldir = "/home/pas/nixos-config/pas/shell";
in {
  # Simple Aliases for devshell environments
  # For bigger projects, rather use direnv with seperate flake.nix files
  # (Which, however, also disables aliases and PS1-modifications, as direnv doesn't permit that in the flake.nix-devShell-shellHook
  programs.bash.shellAliases = {
    c = "nix develop ${devshelldir}/clang";
  };

  # Application file for qtcreator in ./qt
  /*
  xdg.systemDirs.data = [
    inputs.qt-custom.apps."${system}".qtcreator.xdgData
  ];
  */
}
