{
  description = "my project description";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem
    	(system:
        	let pkgs = nixpkgs.legacyPackages.${system}; in
        	{
				packages.bread_os= pkgs.stdenv.mkDerivation {
					pname = "bread_os";
					version = "0.0.1";
					src = ./.;
					nativeBuildInputs =
    					with pkgs; [
							pkgsCross.i686-embedded.buildPackages.gcc 
							grub2 
							xorriso 
							qemu
					];
					
					buildPhase = ''
    					runHook preBuild
						mkdir -p $out

						make bread_os

						mkdir -p $out/isodir/boot/grub
						cp bread_os $out/isodir/boot/bread_os
						cp $src/grub.cfg $out/isodir/boot/grub/grub.cfg
						grub-mkrescue -o bread_os.iso $out/isodir
						cp bread_os.iso $out
    					
						runHook postBuild
  					'';


				};
        		devShells.default = import ./shell.nix { inherit pkgs; };
        	}
      );
}
