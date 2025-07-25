{ pkgs, ... }:
let
  home-manager = fetchTarball {
    url = "https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz";
    sha256 = "1v1r9igz2n7j65rhqspplsq5zg0g1ba4gbkq4042md4nyaf67j24";
  };
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  home-manager.users.andreyfesunov = {
    home.stateVersion = "24.11";

    home.packages = [
      pkgs.pkg-config

      # Gnome Extensions
      pkgs.gnomeExtensions.clipboard-history
      pkgs.gnomeExtensions.dash-to-dock
    ];

    dconf = {
      enable = true;
      settings."org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = with pkgs.gnomeExtensions; [
          clipboard-history.extensionUuid
          dash-to-dock.extensionUuid
        ];
      };
    };

    programs.go = {
      enable = true;
      package = pkgs.go_1_24;
    };
  };
}
