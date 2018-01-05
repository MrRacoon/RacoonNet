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
    imports = [ ./common.nix ../targets/virt.nix ];
  };

  echo1 = echoMachine;
  echo2 = echoMachine;
  echo3 = echoMachine;
  echo4 = echoMachine;
}
