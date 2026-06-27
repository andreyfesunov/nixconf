{ ... }:
{
  home-manager.users.andreyfesunov =
    { pkgs, ... }:
    {
      home.stateVersion = "24.11";

      home.packages = with pkgs; [
        polkit_gnome
        ghostty
        noctalia-shell
        cliphist
      ];

      xdg.configFile."niri/config.kdl".source = ./niri/config.kdl;
      xdg.configFile."noctalia/settings.json" = {
        source = ./noctalia/settings.json;
        force = true;
      };
      xdg.configFile."noctalia/plugins.json" = {
        source = ./noctalia/plugins.json;
        force = true;
      };

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

      systemd.user.services.polkit-gnome-authentication-agent-1 = {
        Unit = {
          Description = "PolicyKit authentication agent";
          After = [ "graphical-session.target" ];
        };
        Service = {
          Type = "simple";
          ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 1;
        };
        Install.WantedBy = [ "graphical-session.target" ];
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
