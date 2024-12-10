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
    # Starts jupyter notebook server
    jupyter notebook &
    
    # Opens the pdf using Zathura PDF reader
    zathura main.pdf &
    
    # Open the jupyter instace at your default browser (Linux environment)
    xdg-open http://127.0.0.1:8888/notebooks/scripts/main.ipynb
  '';
}
