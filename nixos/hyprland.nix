{ pkgs, ... }:

{
  imports = [ ./fonts.nix ];

  environment = {
    etc = {
      "xdg/hypr/hyprlock.conf".source = ../hypr/hyprlock.conf;
      "xdg/waybar/power-menu.xml".source = ../waybar/power-menu.xml;
    };

    systemPackages = with pkgs; [
      hyprpaper
      hyprsysteminfo
      hyprsunset
      hyprshutdown

      tuigreet
      rofi
      gsimplecal
      networkmanagerapplet
      pavucontrol
      playerctl
      brightnessctl
      libnotify
      mako
      wl-mirror
      wl-clipboard
      grim
      slurp

      kitty
      nautilus
    ];

    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
  };

  programs = {
    hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
    };

    waybar.enable = true;
    hyprlock.enable = true;
    nm-applet.enable = true;
  };

  services = {
    blueman.enable = true;

    greetd = {
      enable = true;
      settings.default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --remember-user-session";
        user = "greeter";
      };
    };
  };
}
