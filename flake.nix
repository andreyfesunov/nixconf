{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Custom Flakes
    nixvim.url = "github:andreyfesunov/nixvim";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    ...
  }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit (self) inputs;
        unstable = nixpkgs-unstable.legacyPackages.x86_64-linux;
      };
      modules = [
        ./configuration.nix
        ./modules
      ];
    };
  };
}
