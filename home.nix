{ ... }: {
  home-manager.users.andreyfesunov = { pkgs, ... }: {
    home.stateVersion = "24.11";

    home.packages = with pkgs; [
      polkit_gnome
      ghostty
      noctalia-shell
    ];

    xdg.configFile."niri/config.kdl".source = ./niri/config.kdl;

    systemd.user.services.noctalia-shell = {
      Unit = {
        Description = "Noctalia desktop shell";
        PartOf = [ "niri.service" ];
        After = [
          "niri.service"
          "pipewire.socket"
          "pipewire-pulse.socket"
        ];
        BindsTo = [ "niri.service" ];
        Requires = [ "niri.service" ];
      };
      Service = {
        ExecStart = "${pkgs.noctalia-shell}/bin/noctalia-shell";
        Restart = "on-failure";
      };
      Install.WantedBy = [ "niri.service" ];
    };

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
