{
  description = "Mediapipe Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      python = pkgs.python312Packages;
    in
    {
      packages.${system}.default = python.buildPythonPackage rec {
        pname = "mediapipe";
        version = "0.10.31";
        format = "wheel";

        src = pkgs.fetchPypi rec {
          inherit pname version format;
          platform = "manylinux_2_28_x86_64";
          python = "py3";
          dist = python;
          sha256 = "sha256-Ng3oliBYIkGbFNdXTCgS4IlGdpIo91SMMd2HGxUNm8w=";
        };

        propagatedBuildInputs = with python; [
          numpy
        ];

        doCheck = false;
        pythonImportsCheck = [ "mediapipe" ];
      };
    };
}
