{ ... }: {
  home-manager.users.andreyfesunov = { pkgs, ... }: {
    home.stateVersion = "24.11";

    home.packages = with pkgs; [
      pkg-config
      fuzzel
      swaylock
      gnumake
      swayidle
      polkit_gnome
      swaybg
      ghostty
      ashell
    ];

    xdg.configFile."niri/config.kdl".source = ./niri/config.kdl;
    xdg.configFile."ashell/config.toml".source = ./ashell/config.toml;

    programs.go = {
      enable = true;
      package = pkgs.go_1_26;
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
