.PHONY: switch dry rebuild clean

FLAKE_DIR := /etc/nixos

dry:
	sudo nixos-rebuild switch --flake $(FLAKE_DIR) --dry-run

switch:
	sudo nixos-rebuild switch --flake $(FLAKE_DIR)

rebuild:
	sudo nix flake update --flake $(FLAKE_DIR)
	sudo nixos-rebuild switch --flake $(FLAKE_DIR)

clean:
	sudo nix-collect-garbage --delete-old