{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }: utils.lib.eachDefaultSystem (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      packages = {
        cloudflare-secrets = pkgs.stdenv.mkDerivation {
          name = "secrets";
          src = self;
          installPhase = ''
            mkdir -p $out/bin
            cp ./secrets.sh $out/bin/secrets
            chmod +x $out/bin/secrets
          '';
        };
        cloudflare-dns-list = pkgs.stdenv.mkDerivation {
          name = "dns-list";
          src = self;
          installPhase = ''
            mkdir -p $out/bin
            cp ./dns-list.sh $out/bin/dns-list
            chmod +x $out/bin/dns-list
          '';
        };
        cloudflare-dns-update = pkgs.stdenv.mkDerivation {
          name = "dns-update";
          src = self;
          installPhase = ''
            mkdir -p $out/bin
            cp ./dns-update.sh $out/bin/dns-update
            chmod +x $out/bin/dns-update
          '';
        };
      };
      devShell = with pkgs; mkShell {
        buildInputs = [
          self.packages.${system}.cloudflare-secrets
          self.packages.${system}.cloudflare-dns-list
          self.packages.${system}.cloudflare-dns-update
          jq
        ];
      };
    }
  );
}
