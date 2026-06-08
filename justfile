flake_dir := "/etc/nixos"

[private]
default:
    @just --list

dry:
    sudo nixos-rebuild switch --flake {{flake_dir}} --dry-run

switch:
    sudo nixos-rebuild switch --flake {{flake_dir}}

rebuild:
    sudo nix flake update --flake {{flake_dir}}
    sudo nixos-rebuild switch --flake {{flake_dir}}

clean:
    sudo nix-collect-garbage --delete-old
