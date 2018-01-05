{ pkgs ? import <nixpkgs> {}, ... }:
let
  echoMachine =
    { imports = [ ./echo/machine.nix ]; };
in
{
  network = {
    description = "echo servers";
    enableRollback = true;
  };

  defaults = {
    imports = [ ../targets/virt.nix ];
  };

  echo1 = echoMachine;
}
