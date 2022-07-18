{ pkgs, config, lib, ... }:

{
  sops.secrets.ovh_dns = {
    owner = "acme";
  };

  security.acme = {
    acceptTerms = true;
    defaults = {
      credentialsFile = "/run/secrets/ovh_dns";
      dnsProvider = "ovh";
      email = "nokogiri@gefjon.org";
      group = "nginx";
    };

    certs = {
      "fishoeder.net" = {
        domain = "fishoeder.net";
        extraDomainNames = [
          "*.fishoeder.net"
        ];
      };
      "gefjon.org" = {
        domain = "gefjon.org";
        extraDomainNames = [
          "*.gefjon.org"
        ];
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];

  services.nginx = {
    enable = true;
    virtualHosts."git.fishoeder.net" = {
      useACMEHost = "fishoeder.net";
      forceSSL = true;
      root = "/srv/www/git";
    };

    virtualHosts."media.fishoeder.net" = {
      useACMEHost = "fishoeder.net";
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://10.200.200.1:8096";
        extraConfig =
          "proxy_redirect off;" +
          "proxy_set_header Range $http_range;" +
          "proxy_set_header If-Range $http_if_range;" +
          "proxy_set_header X-Real-IP $remote_addr;" +
          "proxy_set_header Host $host;" +
          "proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;" +
          "proxy_set_header X-Forwarded-Protocol $scheme;" +
          "proxy_http_version 1.1;" +
          "proxy_set_header Upgrade $http_upgrade;" +
          "proxy_set_header Connection \"upgrade\";"
        ;
      };
    };
    virtualHosts."vault.fishoeder.net" = {
      useACMEHost = "fishoeder.net";
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:8284";
        extraConfig =
          "proxy_redirect off;" +
          "proxy_set_header Range $http_range;" +
          "proxy_set_header If-Range $http_if_range;" +
          "proxy_set_header X-Real-IP $remote_addr;" +
          "proxy_set_header Host $host;" +
          "proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;" +
          "proxy_set_header X-Forwarded-Protocol $scheme;" +
          "proxy_http_version 1.1;" +
          "proxy_set_header Upgrade $http_upgrade;" +
          "proxy_set_header Connection \"upgrade\";"
        ;
      };
    };
    virtualHosts."cache.fishoeder.net" = {
      useACMEHost = "fishoeder.net";
      forceSSL = true;
      serverAliases = [ "binarycache" ];
      locations."/".extraConfig = ''
        proxy_pass http://localhost:${toString config.services.nix-serve.port};
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
      '';
    };
    virtualHosts."invid.fishoeder.net" = {
      useACMEHost = "fishoeder.net";
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:3000/";
        extraConfig = '' 
        proxy_set_header X-Forwarded-For $remote_addr;
        proxy_set_header Host $host;
        proxy_http_version 1.1;
        proxy_set_header Connection "";
        '';
      };
    };
  };
}

