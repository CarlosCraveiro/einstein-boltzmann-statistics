{
  description = "Presentation: Determination of the Boltzmann Constant by analyzing Thermal Noise - SME 0123 - Statistics";
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    flake-utils = {
      url = "github:numtide/flake-utils";
    };
  };
  outputs = { nixpkgs, flake-utils, ... }: flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        inherit system;
      };
    in rec {
      devShells.default = import ./shell.nix { inherit pkgs; };
    }
  );
}
