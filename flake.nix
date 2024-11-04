{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }:
	let
        	system = "x86_64-linux";
	in {
    		nixosConfigurations = {
		  inherit system;
    		  nixos = nixpkgs.lib.nixosSystem {
    		    modules = [
    		      ./configuration.nix
    		    ];
    		  };
    		};

		homeConfigurations.tyasheliy = home-manager.lib.homeManagerConfiguration {
		  pkgs = nixpkgs.legacyPackages.${system};
		  modules = [ ./home.nix ];
		};
	};
}
