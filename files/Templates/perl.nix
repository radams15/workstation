{ pkgs ? import <nixpkgs> {} }:
let
  perlLibs = pkgs.perl.withPackages (p: [
    p.DBI
  ]);
in
  pkgs.mkShell {
    buildInputs = with pkgs; [
      perlLibs
    ];
}

