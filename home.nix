{ pkgs, ... }:
let
  home-manager = fetchTarball {
    url = "https://github.com/nix-community/home-manager/archive/release-25.11.tar.gz";
    sha256 = "13fmry1jd0na71fxhzms9qf3ybj6shgvnphq4p1akxxmv44gzq20";
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
      pkgs.gnomeExtensions.dash-to-dock
      pkgs.gnomeExtensions.boost-volume
      pkgs.gnomeExtensions.appindicator
      pkgs.gnomeExtensions.blur-my-shell
      pkgs.gnomeExtensions.just-perfection
      pkgs.gnomeExtensions.space-bar
      pkgs.gnomeExtensions.static-workspace-background
    ];

    dconf = {
      enable = true;
      settings."org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = with pkgs.gnomeExtensions; [
          dash-to-dock.extensionUuid
          boost-volume.extensionUuid
          appindicator.extensionUuid
          blur-my-shell.extensionUuid
          just-perfection.extensionUuid
          space-bar.extensionUuid
          static-workspace-background.extensionUuid
        ];
      };
    };

    dconf.settings = {
      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        ];
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        name = "Vicinae Launcher";
        command = "vicinae toggle";
        binding = "<Super>Return";
      };
    };

    programs.go = {
      enable = true;
      package = pkgs.go_1_24;
    };

    programs.vicinae = {
      enable = true;
      systemd.enable = true;
    };

    programs.tmux = {
      enable = true;
      plugins = with pkgs; [
        tmuxPlugins.minimal-tmux-status
      ];
      extraConfig = ''
        set -g @minimal-tmux-use-arrow true
        set -g @minimal-tmux-right-arrow ""
        set -g @minimal-tmux-left-arrow ""
      '';
    };
  };
}
