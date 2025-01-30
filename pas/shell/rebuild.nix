{ pkgs }:

let
  git = pkgs.git;
in
  pkgs.writeShellScriptBin "rebuild-nat" ''
    set -e
    set -o pipefail
    pushd ~/nixos-configuration

    ${git} diff -U0 --color=always | less -R
    echo -e "\n== Git add =="
    ${git} add * || true
    echo -e "\n== Switching to Nixos with Configuration in ~/nixos-configuration/ =="
    sudo nixos-rebuild switch --flake . 2>&1 | tee nixos-last-switch.log
    echo -e "\n== Committing to git =="
    gen=$(nixos-rebuild list-generations | grep current)
    ${git} commit -am "$gen"

    popd
  ''
