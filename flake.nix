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
  }: let system = "x86_64-linux"; in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit (self) inputs;
        unstable = import nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };
      };
      modules = [
        ./configuration.nix
        ./modules
      ];
    };
  };
}
