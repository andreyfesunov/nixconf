{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz";
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  home-manager.users.andreyfesunov = {
    home.stateVersion = "24.11";

    home.packages = with pkgs; [
      pkg-config
    ];

    programs.go = {
      enable = true;
      package = pkgs.go_1_24;
    }; 
  };
}
