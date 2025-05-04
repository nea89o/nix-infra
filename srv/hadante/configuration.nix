# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  inputs,
  ...
}:
let
  lib = pkgs.lib;
in
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
  ];

  options = {
    user = lib.mkOption {
      type = lib.types.uniq lib.types.str;
      description = "The main user name";

    };
  };
  config = {

    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "hadante"; # Define your hostname.
    user = "nea";

    # Use lesbian nix
    nix.package = pkgs.lix;

    # Enable networking
    networking.networkmanager.enable = true;

    # Set your time zone.
    time.timeZone = "Europe/Berlin";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
      LC_ADDRESS = "de_DE.UTF-8";
      LC_IDENTIFICATION = "de_DE.UTF-8";
      LC_MEASUREMENT = "de_DE.UTF-8";
      LC_MONETARY = "de_DE.UTF-8";
      LC_NAME = "de_DE.UTF-8";
      LC_NUMERIC = "de_DE.UTF-8";
      LC_PAPER = "de_DE.UTF-8";
      LC_TELEPHONE = "de_DE.UTF-8";
      LC_TIME = "de_DE.UTF-8";
    };

    # Enable the GNOME Desktop Environment.
    services.displayManager.ly = {
      settings = {
        animation = "matrix";
        default_input = "password";
        text_in_center = true;
      };
      enable = true;
    };
    # Configure keymap in X11
    services.xserver.xkb = {
      layout = "de";
      variant = "";
    };

    # Configure console keymap
    console.keyMap = "de";

    # Enable CUPS to print documents.
    services.printing.enable = true;

    # Enable sound with pipewire.
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    security.sudo.wheelNeedsPassword = false;
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
    users.users.${config.user} = {
      isNormalUser = true;
      description = "Linnea Gräf";
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
      packages = with pkgs; [
        #  thunderbird
      ];
    };
    users.defaultUserShell = pkgs.zsh;

    nixpkgs.config.allowUnfree = true;

    programs = {
      firefox.enable = true;

      gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
        pinentryPackage = pkgs.pinentry-qt;
      };
      direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
      zsh = {
        enable = true;
        shellInit = ''
          export ZDOTDIR=~/.config/zsh
        '';
      };

      steam.enable = true;
    };
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    fonts.packages = with pkgs; [

      nerd-fonts.comic-shanns-mono
      nerd-fonts.blex-mono
      symbola

    ];

    xdg.portal = {
      enable = true;
      config.common.default = "*";
      wlr = {
        enable = true;
        settings = {
          screencast = {
            chooser_type = "simple";
            chooser_cmd = "${pkgs.slurp}/bin/slurp -f %o -or";
          };
        };
      };
    };

    home-manager.users.${config.user} = {
      programs.kitty = {
        enable = true;
      };
      home.file =
        let
          javas = {
            jdk21 = pkgs.jdk21;
            jdk17 = pkgs.jdk17;
            jdk11 = pkgs.jdk11;
            jdk8 = pkgs.jdk8;
          };
        in

        (lib.attrsets.mapAttrs' (
          label: package:
          lib.attrsets.nameValuePair (".jdks/" + label) {
            source = package;
          }
        ) javas)
        // {
          ".gradle/gradle.properties".text = ''
            org.gradle.java.installations.paths=${
              builtins.concatStringsSep "," (
                builtins.map (name: "/home/" + config.user + "/.jdks/" + name + "/lib/openjdk") (
                  builtins.attrNames javas
                )
              )
            }
          '';
          ".cargo/config.toml".text = ''
            		[net]
            		git-fetch-with-cli = true
            	  '';
        };
      home.stateVersion = "25.05";
    };

    environment.systemPackages = (
      with pkgs;
      [
        neovim
        atuin
        git
        zsh
        yadm
        openssl
        xxd
        pinentry-qt
        emacs
        atuin

        thunderbird
        sway
        webp-pixbuf-loader
        delta
        rofi

        wezterm

        vesktop
        ripgrep

        prismlauncher
        jdk8
        jdk17
        jdk21
        jdk23

        sbctl

        wl-clipboard

        jetbrains.idea-ultimate
        jetbrains.rust-rover

        calibre

        electrum

        myss

        bolt-launcher

        vscode
        gamescope
        nil
        google-chrome
        pwvucontrol

        heroic

        adwaita-icon-theme

        unzip
        file
        zip
        p7zip

        whatsie
      ]
    );
    system.stateVersion = "25.05";
  };
}
