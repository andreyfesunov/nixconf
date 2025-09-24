{...}: {
  users.groups.nix = {};

  users.users.root.extraGroups = ["nix"];

  system.activationScripts.chownEtcNixos = ''
    chown -R root:nix /etc/nixos
    chmod -R 770 /etc/nixos
  '';
}
