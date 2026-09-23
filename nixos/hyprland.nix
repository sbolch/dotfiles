{ pkgs, ... }:

{
  imports = [ ./fonts.nix ];

  environment = {
    systemPackages = with pkgs; [
      tuigreet
      rofi
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
    nm-applet.enable = true;
  };

  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --remember-user-session";
      user = "greeter";
    };
  };
}
