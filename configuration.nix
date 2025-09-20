{ config, pkgs, lib, ...}:

{

  imports = [ ./hardware-configuration.nix ];

  # BOOT

  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
  };

  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Automation
  
  system.autoUpgrade.enable = true;
  system.autoUpgrade.dates = "weekly";

  nix.gc.automatic = true;
  nix.gc.dates ="daily";
  nix.gc.options = "--delete-older-than 10d";
  nix.settings.auto-optimise-store = true;

  # Hostname and NetworkManager

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Timezone

  time.timeZone = "Asia/Kolkata";

  # Locale

  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Display

  services.xserver.enable = true;

  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
    #gtkUsePortal = true;
  };

  services.gnome.gnome-keyring.enable = true;
  services.flatpak.enable = true;


  # Sound

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  
  # NVIDIA/Intel Drivers

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vaapiVdpau
      libvdpau-va-gl
      vulkan-tools
      vulkan-loader
      #vulkan-intel
    ];
  };


  services.xserver.videoDrivers = [ "modesetting" "nvidia" ];

  hardware.nvidia = {
    open = false;
    modesetting.enable = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
  };

  hardware.nvidia.prime = {
    offload.enable = true;
    offload.enableOffloadCmd = true;
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };

  # Virtualisation

  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = [ "suraj" ];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  # Flakes

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Users

  users.users.suraj = {
    isNormalUser = true;
    description = "Suraj Sharma";
    extraGroups = [ "networkmanager" "wheel" "libvirt" ];
    packages = with pkgs; [
      thunderbird
    ];
  };

  # Unfree Packages [EULA]

  nixpkgs.config.allowUnfree = true;

  # System environment
  
  environment.variables = {
    MOZ_ENABLE_WAYLAND = "1";
    LIBVA_DRIVER_NAME = "iHD";
    VDPAU_DRIVER = "va_gl";
  };

  environment.systemPackages = with pkgs; [
    
    # Basic utils
    vim
    wget
    curl
    htop
    unzip
    pciutils
    neofetch
    libva-utils
    killall
    gcc

    # Gnome utils

    gnome-terminal
    gnome-tweaks
  ];

  # networking.firewall.enable = false;
  programs.firefox.enable = true;

  programs.git = {
  enable = true;
  config = [
    {
      user = {
        name = "sjvx";
        email = "sjvxme@google.com";
      };
    }
    {
      core = {
        editor = "nvim";
      };
    }
  ];
};

  
  # System State Version

  system.stateVersion = "25.05";


  ## Extras ##

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;


  # use the example session manager (no others are packaged yet so this is enabled by default,
  # no need to redefine it in your config for now)
  # media-session.enable = true;

}
