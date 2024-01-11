{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils, fenix, ... }: (utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs { inherit system; };
      version = "0.0.1";
      plainName = "hash2slash";
      rust-cargo = fenix.packages."${system}".minimal.toolchain;
    in
    {
      packages = {
        go-yaegi = pkgs.stdenv.mkDerivation rec {
          inherit version;
          name = "${plainName}-go-yaegi";
          src = ./src;
          nativeBuildInputs = [ pkgs.makeBinaryWrapper ];
          buildInputs = [ pkgs.yaegi ];
          installPhase = ''
            mkdir -p $out/bin
            cat exec.sh | sed 's/EXEC/yaegi/g' | tee $out/bin/${name}
            chmod +x $out/bin/${name}
            wrapProgram $out/bin/${name}  --prefix PATH : ${pkgs.lib.makeBinPath [ pkgs.yaegi ]}
          '';
        };

        go-run = pkgs.stdenv.mkDerivation rec {
          inherit version;
          name = "${plainName}-go-run";
          src = ./src;
          nativeBuildInputs = [ pkgs.makeBinaryWrapper ];
          buildInputs = [ pkgs.go ];
          installPhase = ''
            mkdir -p $out/bin
            cat exec-mv.sh | sed 's/EXEC/go run/g' | tee $out/bin/${name}
            chmod +x $out/bin/${name}
            wrapProgram $out/bin/${name}  --prefix PATH : ${pkgs.lib.makeBinPath [ pkgs.go ]}
          '';
        };


        kotlin = pkgs.stdenv.mkDerivation rec {
          inherit version;
          name = "${plainName}-kotlin";
          src = ./src;
          nativeBuildInputs = [ pkgs.makeBinaryWrapper ];
          buildInputs = [ pkgs.kotlin ];
          installPhase = ''
            mkdir -p $out/bin
            cat exec-mv.sh | sed 's/EXEC/kotlin/g' | tee $out/bin/${name}
            chmod +x $out/bin/${name}
            wrapProgram $out/bin/${name}  --prefix PATH : ${pkgs.lib.makeBinPath [ pkgs.kotlin ]}
          '';
        };
      };
    }
  ));
}
