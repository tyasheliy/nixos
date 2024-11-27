# TODOS:
# 1. file structure
# 2. configure v2raya with re:filter geoip (and del nekoray)
# 3. configure zsh
# 4. bspwm mouse focus
# 5. more sxhkd bindings (move, focus, resize?)

{ config, pkgs, ... }:

{
  imports =
    [       
		./hardware-configuration.nix
    ];

  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.gc = { 
  	automatic = true; 
	dates = "daily"; 
	options = "--delete-older-than 7d"; 
  };

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Moscow";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  sound.enable = true;
  hardware.pulseaudio = {
	enable = true;
	support32Bit = true;
  };

  programs.zsh.enable = true;

  users.users.tyasheliy = {
    isNormalUser = true;
    description = "tyasheliy";
    extraGroups = [
		"networkmanager" 
		"wheel" 
		"docker"
		"audio"
		"input"
	];
    shell = pkgs.zsh;
    useDefaultShell = true;
  };

  #services.getty.autologinUser = "tyasheliy";

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
     firefox
	 nekoray
     vim 
     home-manager
     unzip
     gnumake
	 pass
	 docker-credential-helpers
  ];

  virtualisation.docker = {
	enable = true;
  };


  services.xserver = {
	enable = true;
	displayManager = {
		startx.enable = true;
  	};
	xkb = {
		layout = "us,ru";
		options = "grp:caps_toggle";
	};
	windowManager = {
		bspwm.enable = true;
	};
  };

  system.stateVersion = "24.05"; # Did you read the comment?
}
