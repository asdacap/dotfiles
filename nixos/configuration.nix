
# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = ["ntfs"];

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # For wireguard
  networking.firewall.checkReversePath = false; 

  # Set your time zone.
  time.timeZone = "Asia/Kuala_Lumpur";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ms_MY.UTF-8";
    LC_IDENTIFICATION = "ms_MY.UTF-8";
    LC_MEASUREMENT = "ms_MY.UTF-8";
    LC_MONETARY = "ms_MY.UTF-8";
    LC_NAME = "ms_MY.UTF-8";
    LC_NUMERIC = "ms_MY.UTF-8";
    LC_PAPER = "ms_MY.UTF-8";
    LC_TELEPHONE = "ms_MY.UTF-8";
    LC_TIME = "ms_MY.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.desktopManager.xterm.enable = true;

  services.xserver.desktopManager.xfce = {
	enable = true;
	noDesktop = true;
	enableXfwm = false;
  };

  services.xserver.windowManager.i3 = {
	enable = true;
	extraPackages = with pkgs; [
		dmenu
		i3-auto-layout
		i3status
		i3lock
		i3blocks
	];
  };

  # Collectd
  services.collectd.enable = true;
  services.collectd.plugins = {
    processes = ''
   <ProcessMatch "nethermind" "nethermind">
     CollectFileDescriptor true
     CollectContextSwitch true
     CollectMemoryMaps true
   </ProcessMatch>
   <ProcessMatch "geth" "geth">
     CollectFileDescriptor true
     CollectContextSwitch true
     CollectMemoryMaps true
   </ProcessMatch>
   <ProcessMatch "paprika" "Paprika">
     CollectFileDescriptor true
     CollectContextSwitch true
     CollectMemoryMaps true
   </ProcessMatch>
   <ProcessMatch "tbot4rust" "do_auto_search">
     CollectFileDescriptor true
     CollectContextSwitch true
   </ProcessMatch>
   <ProcessMatch "juno" "juno">
     CollectFileDescriptor true
     CollectContextSwitch true
   </ProcessMatch>
   <ProcessMatch "tbot4rust2" "tbot4rust">
     CollectFileDescriptor true
     CollectContextSwitch true
   </ProcessMatch>
   <ProcessMatch "juno-large" "largejuno">
     CollectFileDescriptor true
     CollectContextSwitch true
   </ProcessMatch>
 '';
    write_prometheus = ''Port "9103"'';
    disk = "";
    interface = "";
    cpu = "";
    sensors = "";
  };
  services.collectd.user = "root"; # look, I gave up okay?

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.amirul = {
    isNormalUser = true;
    description = "amirul";
    extraGroups = [ "networkmanager" "wheel" "docker"];
    packages = with pkgs; [
      firefox
      google-chrome
      home-manager
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
    unzip
    jdk
    iotop
    sysstat
    mdadm
    smartmontools
    pciutils
    dmidecode
    cpupower-gui
    pasystray
    xfce.xfce4-pulseaudio-plugin
    pavucontrol
    ethtool
    busybox
    docker-compose
    docker-credential-gcr
    google-cloud-sdk
    libcap_ng
    cpufrequtils
    iptables
    gnome3.gnome-tweaks
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  #networking.firewall.allowedTCPPorts = [ 30303 9000 8081 ];
  #networking.firewall.allowedUDPPorts = [ 30303 9000 ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

  programs.zsh.enable = true;
  programs.java.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Make sure opengl is enabled
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  services.prometheus = {
    enable = true;
    
    globalConfig.scrape_interval = "5s";
    scrapeConfigs = [
      {
        job_name = "nethermind";
	static_configs = [{
	  targets = ["localhost:9999"]; 
	}];
      }
      {
        job_name = "nethermind2";
	static_configs = [{
	  targets = ["localhost:9998"]; 
	}];
      }
      {
        job_name = "collectd";
	static_configs = [{
	  targets = ["localhost:9103"]; 
	}];
      }
      {
        job_name = "tbot4python";
	static_configs = [{
	  targets = ["localhost:10001"]; 
	}];
      }
      {
        job_name = "tbot4rust";
	static_configs = [{
	  targets = ["localhost:9184"]; 
	}];
      }
      {
        job_name = "juno";
	static_configs = [{
	  targets = ["localhost:9201"]; 
	}];
      }
      {
        job_name = "scratchpython";
	static_configs = [{
	  targets = ["localhost:20002"]; 
	}];
      }
    ];
  };

  services.grafana = {
    enable = true;
    settings = {
      server = {
        http_addr = "127.0.0.1";
        http_port = 3000;
        root_url = "http://localhost:3000/";
      };
    };
  };

  virtualisation.docker.enable = true;
}

