{ pkgs ? import <nixpkgs> { } }:
pkgs.mkShell {
	nativeBuildInputs =
    	with pkgs; [
        	pkgsCross.i686-embedded.buildPackages.gcc 
			grub2 
			xorriso 
			qemu
			(pkgs.python3.withPackages (python-pkgs: with python-pkgs; []))
		];
}
