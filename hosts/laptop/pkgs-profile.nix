{ pkgs, inputs, ...}:
let 
    system = pkgs.stdenv.hostPlatform.system;
in
{
    bluetooth = with pkgs; [
        overskride
        bluez
    ];

    audio = with pkgs; [
        pavucontrol
        crosspipe
    ];

    shell = with pkgs; [
        zsh
        zsh-fzf-tab
        zsh-autosuggestions
        zsh-syntax-highlighting
        eza
        yazi
        fzf
        zoxide
        starship
        brightnessctl
        killall
        htop
        libnotify
        fyi
        bitwarden-cli
        proton-pass-cli
        gpu-screen-recorder
    ];

    workflow = with pkgs; [
        git
        lazygit
        gnumake
        dotbot
    ];

    browsers = with pkgs; [
        firefox
        ungoogled-chromium
    ];

    editors = with pkgs; [
        inputs.kvim.packages.${system}.neuvim
        nvchad
    ];

    desktop = with pkgs; [
        xournalpp
        obsidian
        signal-desktop
        libreoffice
	      kitty
	      foot
        goofcord
        kdePackages.kdenlive
        (prismlauncher.override {
            additionalPrograms = [ ffmpeg ];
            additionalLibs = [ glfw3-minecraft ];
            jdks = [
                jdk25 
                jdk21
                jdk17
            ];
         })
        inputs.freesmLauncher.packages.${system}.freesmlauncher
        inputs.icon-browser.packages.${system}.default
        nautilus
        amberol
    ];

    email = with pkgs; [
        thunderbird
    ];

    qtPackages = with pkgs.kdePackages; [
        qt6ct
        dolphin
    ];

    misc = with pkgs; [
        addwater
        (inputs.quickshell.packages.${system}.default.withModules [
            pkgs.kdePackages.kirigami
            pkgs.kdePackages.qtmultimedia
            pkgs.kdePackages.qt5compat
            pkgs.kdePackages.qtimageformats
        ])
        matugen
        cachix
        powertop
        glib
    ];

    network = with pkgs; [
        tailscale
        trayscale
    ];

    icons = with pkgs; [
        papirus-icon-theme
        adwaita-icon-theme
        fluent-icon-theme
        morewaita-icon-theme
        inputs.pebble-icon-theme.packages.${system}.all
    ];

    cursor = with pkgs; [
        bibata-cursors
    ];

    wayland = with pkgs; [
        wl-clipboard
        hyprshot
        xwayland-satellite
    ];
}
