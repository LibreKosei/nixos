{ pkgs, config, inputs, ...}:
let 
    pkg-groups = import ./pkgs-profile.nix { inherit pkgs inputs; };
in
{
    # Custom Module 
    modules = {
        services = {
            minecraft.enable = true;
        };
    };

    # Built-in Module
    imports = [ 
        ./hardware-configuration.nix 
        ./programs.nix
        ./misc.nix
    ];

    boot = {
        loader = {
            systemd-boot.enable = true;
            efi.canTouchEfiVariables = true;
        };

        kernelParams = [ "usbcore.autosuspend=-1" ];
    };

    hardware = {
        opentabletdriver.enable = true;
        uinput.enable = true;
        bluetooth = {
            enable = true;
            powerOnBoot = true;
        };
        graphics = {
            enable = true;
            extraPackages = with pkgs; [
                intel-media-driver
                intel-compute-runtime
                vaapiIntel
                vaapiVdpau
                libvdpau-va-gl
            ];
        };
    };

    networking = {
        hostName = "nixos";
        networkmanager.enable = true;
        ### Tailscale VPN
        firewall = {
            enable = true;
            trustedInterfaces = [ "tailscale0" ];
            allowedUDPPorts = [ 41641 ];
            allowedTCPPorts = [ 22 ];
        };
    };

    services = {
        upower.enable = true;
        gnome.gnome-keyring.enable = true;

        pipewire = {
            enable = true;
            audio.enable = true;
            pulse.enable = true;
            alsa = {
                enable = true;
                support32Bit = true;
            };
            wireplumber = {
                enable = true;
            };
        };

        logind = {
            settings.Login = {
                HandleLidSwitchDocked = "suspend";
                HandleLidSwitch = "suspend";
            };
        };

        acpid.enable = true;
        thermald.enable = true;

        tlp = {
            enable = true;
        };

        tailscale.enable = true;

        hypridle.enable = true;
    };

    powerManagement.enable = true;

    security = {
        polkit.enable = true;
        pam.services.login.enableGnomeKeyring = true;
    };

    users = {
        users = {
            kosei = {
                isNormalUser = true;
                extraGroups = [ "wheel" "libvirtd" "networkmanager" ];
                shell = pkgs.zsh;
                packages = builtins.concatLists (with pkg-groups; [
                    bluetooth
                    audio
                    shell
                    browsers
                    editors 
                    desktop
                    qtPackages 
                    misc
                    network
                    workflow
                ]);
            };
        };
    };

    xdg.portal = {
        enable = true;
        extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
    };

    nixpkgs.config.allowUnfree = true;

    environment = {
        pathsToLink = [ "/share/zsh" ];
        sessionVariables = {
            NIXOS_OZONE_WL = "1";
            QT_QPA_PLATFORM = "wayland;xcb";
            QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
            MOZ_ENABLE_WAYLAND = "1";
            SDL_VIDEODRIVER = "wayland";
            CLUTTER_BACKEND = "wayland";
            XDG_SESSION_TYPE = "wayland";
            XDG_CURRENT_DESKTOP = "Hyprland";
            LIBVA_DRIVER_NAME = "iHD";
            GAME_NATIVE_GLFW = "1";
        };
    };

    nix = {
        settings = {
            experimental-features = [ "nix-command" "flakes" ];
            substituters = [ 
                "https://hyprland.cachix.org" 
                "https://nix-community.cachix.org"
            ];
            trusted-substituters = [ "https://hyprland.cachix.org" ];
            trusted-public-keys = [ 
                "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" 
                "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
            ];
            trusted-users = [ "root" "@wheel" ];
        };
    };

    # time 
    time.timeZone = "Asia/Kuala_Lumpur";

    # font
    fonts = {
        packages = with pkgs; [
            fira-code
            fira-code-symbols
            font-awesome
            noto-fonts-color-emoji
            noto-fonts-cjk-sans
            nerd-fonts.jetbrains-mono
            corefonts
            vista-fonts
            ibm-plex
        ];
        fontDir.enable = true;
        fontconfig = {
            defaultFonts.monospace = ["JetBrainsMono Nerd Font"];
        };
    }; 

    # locale
    i18n = {
        defaultLocale = "en_US.UTF-8";
        extraLocales = "all";
        inputMethod = {
            type = "fcitx5";
            enable = true;
            fcitx5.waylandFrontend = true;
            fcitx5.addons = with pkgs; [
                fcitx5-mozc
                fcitx5-gtk
                fcitx5-hangul
            ];
        };
    };
    
}
