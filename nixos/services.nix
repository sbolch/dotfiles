{ pkgs, ... }:

{
  services.openssh.enable = true;

  # Hardware

  hardware.cpu.amd.updateMicrocode = true;
  hardware.enableRedistributableFirmware = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  services.fstrim.enable = true;
  services.fwupd.enable = true;
  services.power-profiles-daemon.enable = true;

  # Audio

  security.rtkit.enable = true;
  
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Login
  
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --remember-user-session";
        user = "greeter";
      };
    };
  };

  # YubiKey

  services.udev.packages = with pkgs; [
    yubikey-personalization
  ];

  services.pcscd.enable = true;
}
