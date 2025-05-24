{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz";
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  home-manager.users.andreyfesunov = {
    home.stateVersion = "24.11";

    programs.go = {
      enable = true;
      package = pkgs.go_1_24;
    };
  };
}
