{ pkgs ? import <nixpkgs> {}, ... }:

with pkgs; stdenv.mkDerivation {
  name = "echo";
  src = ./echo.tar.gz;
  installPhase = ''
    mkdir $out
    cp -r ./* $out
  '';
}
