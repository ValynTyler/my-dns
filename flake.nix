{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }:
  let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
  in
  {
    packages.x86_64-linux.cf-secrets = pkgs.stdenv.mkDerivation {
      name = "secrets";
      src = self;
      installPhase = ''
        mkdir -p $out/bin
        cp ./secrets.sh $out/bin/secrets
        chmod +x $out/bin/secrets
      '';
    };

    packages.x86_64-linux.dns-list = pkgs.stdenv.mkDerivation {
      name = "dnslist";
      src = self;
      installPhase = ''
        mkdir -p $out/bin
        cp ./dns-list.sh $out/bin/dnslist
        chmod +x $out/bin/dnslist
      '';
    };

    packages.x86_64-linux.dns-update = pkgs.stdenv.mkDerivation {
      name = "dnsupdate";
      src = self;
      installPhase = ''
        mkdir -p $out/bin
        cp ./dns-update.sh $out/bin/dnsupdate
        chmod +x $out/bin/dnsupdate
      '';
    };

    devShells.x86_64-linux.default = pkgs.mkShell {
      buildInputs = with pkgs; [
        self.packages.x86_64-linux.cf-secrets
        self.packages.x86_64-linux.dns-list
        self.packages.x86_64-linux.dns-update
        jq
      ];
    };
  };
}
