{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    curl
    wget
    git

    pciutils
    usbutils
    vulkan-tools
    mesa-demos
    
    tuigreet
    rofi
    networkmanagerapplet
    pavucontrol
    playerctl
    brightnessctl
    wireplumber
    libnotify
    mako
    wl-clipboard
    grim
    slurp

    helix
    dysk
    fastfetch
    
    yubikey-manager
    yubioath-flutter
    pam_u2f
    libfido2

    kitty
    nautilus
    firefox
    chromium
    mpv
    spotify
    zed
    jetbrains-toolbox
  ];

  programs.bash.shellAliases = {
    nix-switch = "sudo nixos-rebuild switch -I nixos-config=/home/szabolcs/.config/nixos/configuration.nix";
  };

  programs.fish = {
    enable = true;
    shellAliases = {
      nix-switch = "sudo nixos-rebuild switch -I nixos-config=/home/szabolcs/.config/nixos/configuration.nix";
    };
  };

  programs.ssh.startAgent = true;
  
  programs.gnupg.agent.enable = true;

  programs.yazi = {
    enable = true;
    settings = {
      yazi = {
        mgr = {
          show_hidden = true;
        };
      };
    };
  };

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
  
  programs.waybar.enable = true;

  programs.steam = {
    enable = true;
    protontricks.enable = true;
  };
}
