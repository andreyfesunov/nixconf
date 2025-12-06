{pkgs, ...}: let
  home-manager = fetchTarball {
    url = "https://github.com/nix-community/home-manager/archive/release-25.11.tar.gz";
    sha256 = "1qr63a2izlp840ax3v31avji99yprw3rap2m8f1snfkxfnsh8syh";
  };
in {
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
      pkgs.gnomeExtensions.boost-volume
    ];

    dconf = {
      enable = true;
      settings."org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = with pkgs.gnomeExtensions; [
          clipboard-history.extensionUuid
          dash-to-dock.extensionUuid
          boost-volume.extensionUuid
        ];
      };
    };

    programs.go = {
      enable = true;
      package = pkgs.go_1_24;
    };
  };
}
