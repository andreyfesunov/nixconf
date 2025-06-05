{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
	
    # Custom Flakes
    nixvim.url = "github:andreyfesunov/nixvim";
  };

  outputs = { self, nixpkgs, nixvim, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit (self) inputs; };
      modules = [
        ./configuration.nix
	./modules 
      ];
    };
  };
}
