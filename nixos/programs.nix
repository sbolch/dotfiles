{ pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      curl
      wget

      pciutils
      usbutils

      helix
      dysk
      fastfetch

      yubikey-manager
      yubioath-flutter
      pam_u2f
      libfido2

      firefox
      chromium
      bitwarden-desktop
    ];
  };

  programs = {
    fish.enable = true;

    yazi = {
      enable = true;
      settings.yazi.mgr.show_hidden = true;
    };
  };

  services = {
    udev.packages = with pkgs; [
      yubikey-personalization
    ];
    pcscd.enable = true;

    tailscale.enable = true;
  };
}
