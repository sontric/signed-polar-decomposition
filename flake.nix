{
  description = "Ultra-light deterministic Markdown → PDF builder (Pandoc + Tectonic)";

  inputs = {
    # Pinned nixpkgs revision (NixOS 25.05 channel commit).
    nixpkgs.url = "github:NixOS/nixpkgs/b1b329146965";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            git
            gnumake
            coreutils
            findutils
            which
            python3
            python3Packages.sympy
            python3Packages.numpy
            python3Packages.matplotlib
            python3Packages.jupyter
            python3Packages.ipykernel
            quarto
            tectonic
            vscodium
          ];

          # Determinism & safety knobs. Tectonic in Nix uses a pinned bundle,
          # so no network fetches are needed at build time.
          env = {
            TECTONIC_UNTRUSTED_MODE = "1";
            # CI/Makefile will set this to the latest commit time; fall back to 0.
            SOURCE_DATE_EPOCH = "0";
            LC_ALL = "C";
            TZ = "UTC";
          };
        };
      });
}
