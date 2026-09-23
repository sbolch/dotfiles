{ pkgs, ... }:

{
  fonts = {
    packages = with pkgs; [
      fira-sans
      nerd-fonts.fira-code
      source-serif
      openmoji-color
    ];

    fontconfig.defaultFonts = {
      sansSerif = [ "Fira Sans" ];
      serif = [ "Source Serif 4" ];
      monospace = [ "FiraCode Nerd Font Mono" ];
      emoji = [ "OpenMoji" ];
    };

    enableDefaultPackages = true;
  };
}
