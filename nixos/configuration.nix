{ pkgs, ... }:

{
  imports = [
    /etc/nixos/hardware-configuration.nix
    ./locale.nix
    ./hyprland.nix
    ./programs.nix
    ./work.nix
    ./relax.nix
  ];

  system.stateVersion = "26.05";

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
  };

  hardware = {
    cpu.amd.updateMicrocode = true;
    enableRedistributableFirmware = true;
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };

  services = {
    openssh.enable = true;
    fstrim.enable = true;
    fwupd.enable = true;
    power-profiles-daemon.enable = true;
  };

  # Sound
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
  };

  networking = {
    hostName = "Aby";
    networkmanager.enable = true;
  };

  users.users."szabolcs" = {
    isNormalUser = true;
    description = "Szabolcs Surányi";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
  };

  environment.shellAliases = {
    nix-switch = "sudo nixos-rebuild switch -I nixos-config=/home/szabolcs/.config/nixos/configuration.nix";
  };

  nixpkgs.config.allowUnfree = true;
}
