{
  description = "A Nix-Flake-based C++-Environment-Shell";

  outputs = {
    self,
    nixpkgs,
    ...
  }: let
    system = "x86_64-linux";
  in {
    devShells."${system}".default = let
      pkgs = import nixpkgs {inherit system;};
    in
      pkgs.mkShell {
        packages = with pkgs; [
          clang
        ];

        shellHook = ''
          export PS1="\n \[\e[1;34m\]== CPP: \w ==\n $\[\e[m\] "
          alias cpp="clang++ -Wall -Wextra -std=c++17 -O3 -pedantic-errors -fsanitize=address -fsanitize=undefined -fno-sanitize-recover=all"
          echo -e "\nclang++ `${pkgs.clang}/bin/clang++ --version`"
        '';
      };
  };
}
