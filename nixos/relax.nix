{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    mpv
    spotify

    vulkan-tools
    mesa-demos
  ];

  programs.steam = {
    enable = true;
    protontricks.enable = true;
  };

  hardware.graphics.enable32Bit = true;
}
