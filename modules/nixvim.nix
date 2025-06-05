{ pkgs, inputs, ...}: {
  environment.systemPackages = [
    inputs.nixvim.packages.${pkgs.system}.default
  ];
}
