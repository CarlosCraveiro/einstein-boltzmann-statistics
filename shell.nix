{ pkgs ? import <nixpkgs> { } }:
with pkgs;
mkShell {
  buildInputs = [
    (python3.withPackages(ps: with ps; [
       ipython
       jupyter
       matplotlib
       numpy
       pandas
       mpmath
       scipy
    ]))

    nixpkgs-fmt
    typst
    pdfpc
    zathura
  ];
  
  shellHook = ''
    jupyter notebook
  '';
}
