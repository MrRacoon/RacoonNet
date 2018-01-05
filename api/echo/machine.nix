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

      after = [ "network.target" ];

      environment = {
        NAME = "echo";
        PORT = "8080";
      };

      serviceConfig = {
        ExecStart = "${node}/bin/node ${echo}/index.js";
        User = "nodejs";
        Restart = "always";
      };

      wantedBy = [ "multi-user.target" ];
    };

    users.extraUsers = {
      nodejs = { };
    };
  }
