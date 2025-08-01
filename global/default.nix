{
  config,
  lib,
  pkgs,
  inputs,
  system,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./gui.nix
    ../pas/shell/scripts.nix
  ];

  environment.systemPackages = with pkgs; [
    tree
    kitty
    man-pages
    man-pages-posix
    inputs.nix-alien.packages."${system}".nix-alien
    qemu_full
    quickemu
    wineWowPackages.waylandFull
    winetricks
    distrobox
  ];

  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
      warn-dirty = false;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "pas-nixos";
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/Vienna";

  i18n = {
    defaultLocale = "en_GB.UTF-8";
    extraLocaleSettings = lib.attrsets.genAttrs [
      "LC_NUMERIC"
      "LC_TIME"
      "LC_MONETARY"
      "LC_PAPER"
      "LC_NAME"
      "LC_ADDRESS"
      "LC_TELEPHONE"
      "LC_MEASUREMENT"
    ] (locale: "de_AT.UTF-8");

    inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5.addons = with pkgs; [
	fcitx5-mozc
	kdePackages.fcitx5-qt
	kdePackages.fcitx5-chinese-addons
	fcitx5-tokyonight
      ];
      fcitx5.waylandFrontend = true;
      fcitx5.settings.inputMethod = {
	GroupOrder."0" = "Default";
	"Groups/0" = {
	  Name = "Default";
	  "Default Layout" = "de-e1";
	  DefaultIM = "mozc";
	};
	"Groups/0/Items/0".Name = "keyboard-de-e1";
	"Groups/0/Items/1".Name = "mozc";
	"Groups/0/Items/2".Name = "pinyin";
      };
    };
  };

  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
  ];
  fonts.enableDefaultPackages = true;

  services = {
    xserver = {
      xkb = {
        layout = "de";
        options = "eurosign:e,caps:escape";
      };

      desktopManager.runXdgAutostartIfNone = true; # for Fcitx5 to work in WMs
    };

    pipewire = {
      enable = true;
      pulse.enable = true;
    };

    stirling-pdf = {
      enable = true;
      environment = { SERVER_PORT = 8081; };
    };

    blueman.enable = true;
    envfs.enable = true;
  };

  # For envfs
  environment.shellInit = ''
    export ENVFS_RESOLVE_ALWAYS=1
  '';

  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
      configure.customRC = ''
	set shiftwidth=2
	set number
	set expandtab
      '';
    };
    vim.enable = true;

    partition-manager.enable = true;

    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };

    appimage = {
      enable = true;
      binfmt = true;
    };

    nix-ld.enable = true;
    git = {
      enable = true;
      prompt.enable = true;
    };
  };

  virtualisation = {
    docker.enable = true;
    podman = {
      enable = true;
    };
  };

  users.users.pas = {
    isNormalUser = true;
    extraGroups = ["wheel" "input" "networkmanager" "vboxsf" "docker" ];
  };

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };

  documentation.dev.enable = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?
}
