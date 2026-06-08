{ pkgs, ... }: {
  home-manager.users.andreyfesunov = {
    home.stateVersion = "24.11";

    home.packages = with pkgs; [
      pkg-config
      fuzzel
      swaylock
      waybar
      gnumake
      swayidle
      polkit_gnome
      swaybg
      ghostty
    ];

    xdg.configFile."niri/config.kdl".source = ./config.kdl;

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
