{ config, pkgs, ... }:

let
  phpDev = pkgs.php.withExtensions (
    { enabled, all }:
    enabled ++ (with all; [
      apcu
      ds
      imagick
      redis
    ])
  );
  unstable = import <nixpkgs-unstable> {
    config = config.nixpkgs.config;
  };
in
{
  environment.systemPackages = with pkgs; [
    git
    phpDev
    phpDev.packages.composer
    go
    python3
    gleam
    vlang
    nodejs
    bun

    zed-editor
    jetbrains-toolbox
    podman-desktop
    unstable.opencode
  ];

  programs = {
    ssh.startAgent = true;
    gnupg.agent.enable = true;
  };

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    dockerSocket.enable = true;
  };
  users.users."szabolcs".extraGroups = [ "podman" ];
}
