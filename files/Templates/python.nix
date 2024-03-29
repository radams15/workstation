{ pkgs ? import <nixpkgs> {} }:
let
  pyPkgs = pkgs.python3.withPackages (p: [
    p.requests
  ]);
in
  pkgs.mkShell {
    nativeBuildInputs = with pkgs.buildPackages; [
      pyPkgs
    ];
}

