{ config, pkgs, ... }:

{
  imports = [
    /etc/nixos/hardware-configuration.nix
    ./locale.nix
    ./services.nix
    ./programs.nix
  ];

  system.stateVersion = "26.05";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "Aby";
  networking.networkmanager.enable = true;

  users.users."szabolcs" = {
    isNormalUser = true;
    description = "Szabolcs Surányi";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
    shell = pkgs.fish;
  };

  nixpkgs.config.allowUnfree = true;
}
