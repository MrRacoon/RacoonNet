{ pkgs ? import <nixpkgs> {}, ... }:
let
  ec2 = import ../targets/ec2.nix {};
  echoMachine =
    { imports = [ ./echo/machine.nix ]; };
in
{
  network = {
    description = "echo servers";
    enableRollback = true;
  };

  defaults = {
    imports = [ ./common.nix ../targets/ec2.nix ];
  };

  echo1 = echoMachine;
  echo2 = echoMachine;
  echo3 = echoMachine;

  resources.ec2KeyPairs.my-key-pair = {
    region = "us-west-2";
    accessKeyId = "default";
  };
}
