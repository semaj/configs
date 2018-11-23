# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nixpkgs.config.allowUnfree = true;
  # Use the GRUB 2 boot loader.
  boot.loader.systemd-boot.enable = true;
  networking = {
    hostName = "prometheus";
    hostId = "0d3f4c3d";
    nameservers = ["1.1.1.1" "1.0.0.1"];
  };
  #boot.loader.grub.version = 2;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  # boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only

  # networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  # Set your time zone.
  # time.timeZone = "Europe/Amsterdam";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     wget 
     curl
     neovim
     i3
     arc-theme
     papirus-icon-theme
     blueman
     dnsutils
     firefox
     thunderbird
     konsole
     okular
     spotify
     ripgrep
     tmux
     git
     stack
     fzf
     zotero
     rustc
     cargo
     ruby
     python3
     openssl
     mosh
     jetbrains.idea-community
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };
# List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.permitRootLogin = "yes";

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.bluetooth.enable = true;

  # Enable touchpad support.
  # services.xserver.libinput.enable = true;

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.09"; # Did you read the comment?
  programs.zsh.enable = true;

  users.users.james = {
    isNormalUser = true;
    name = "james";
    group = "users";
    extraGroups = [
      "wheel" "sudo" "docker" "lpadmin" "networkmanager"
    ];
    createHome = true;
    uid = 1000;
    home = "/home/james";
    shell = pkgs.zsh;
  };

  services.xserver = {
    enable = true;   
    displayManager.slim = {
      enable = true;
      theme = pkgs.fetchurl {
        url = "https://github.com/semaj/configs/raw/master/slim_themes/overlay.tar.gz";
	sha256 = "8608998bd2d6f6ba1eca078d60be3fa1bef0db293d249e52ead21c97e6af628c";
      };
    };
    desktopManager = {
      default = "xfce";
      xterm.enable = false;
      xfce = {
        enable = true;
        noDesktop = false;
        enableXfwm = false;
      };
    };
    windowManager.i3.enable = true;
  };
}
