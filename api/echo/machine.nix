{ pkgs ? import <nixpkgs> {}, ... }:
let
  echo = import ./default.nix {};
  node = pkgs.nodejs-8_x;
in
  {
    networking.firewall.enable = true;
    networking.firewall.allowedTCPPorts = [ 80 8080 ];
    networking.firewall.allowPing = true;
    networking.firewall.extraCommands = ''
      iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 8080
    '';

    systemd.services.echoserver = {
      description = "A basic echo server";

      # Configuration
      environment = {
        NAME = "echo";
        PORT = "8080";
      };

      # Start command and user to run it as
      serviceConfig = {
        ExecStart = "${node}/bin/node ${echo}/index.js";
        User = "nodejs";
        Restart = "always";
      };

      # start the service on boot, after networking is enabled
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
    };

    users.extraUsers = {
      nodejs = { };
    };
  }
