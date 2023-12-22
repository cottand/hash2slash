{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
  inputs.utils.url = "github:numtide/flake-utils";



  outputs = { self, nixpkgs, utils, ... }: (utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs { inherit system; };
      version = "0.0.1";
      plainName = "hash2slash";
    in
    {
      packages = rec {
        go = pkgs.stdenv.mkDerivation rec {
          inherit version;
          name = "${plainName}-go";
          src = ./src;
          nativeBuildInputs = [ pkgs.makeBinaryWrapper ];
          buildInputs = [ pkgs.yaegi ];
          installPhase = ''
            mkdir -p $out/bin
            cat exec.sh | sed 's/EXEC/yaegi/g' | tee $out/bin/${name}
            cat  $out/bin/${name}
            chmod +x $out/bin/${name}
            wrapProgram $out/bin/${name}  --prefix PATH : ${pkgs.lib.makeBinPath [ pkgs.yaegi ]}
          '';
        };
      };
    }
  ));
}
