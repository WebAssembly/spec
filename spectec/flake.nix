{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs";

  description = "Nix infrastructure for spectec";
  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      devShells.${system}.default =
        pkgs.mkShell {
          packages = with pkgs; [
            dune_3
            ocamlPackages.ocaml
            ocamlPackages.menhir
            ocamlPackages.mdx
          ];
        };
    };
}
