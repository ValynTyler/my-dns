{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }:
  let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
  in
  {
    packages.x86_64-linux.default = self.packages.x86_64-linux.cf-secrets;
    packages.x86_64-linux.cf-secrets = pkgs.stdenv.mkDerivation {
      name = "secrets";
      src = self;
      installPhase = ''
        mkdir -p $out/bin
        cp ./secrets.sh $out/bin/secrets
        chmod +x $out/bin/secrets
      '';
    };

    devShells.x86_64-linux.default = pkgs.mkShell {
      buildInputs = with pkgs; [
        self.packages.x86_64-linux.cf-secrets
        jq
      ];
    };
  };
}
